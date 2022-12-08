//
//  Cache.swift
//  Avito
//
//  Created by Кирилл Сурков on 28.10.2022.
//

import Foundation

final class Cache<Key: Hashable, Value> {
    
    // MARK: - Private properties

  private let wrapped = NSCache<WrappedKey, Entry>()
  private let dateProvider: () -> Date
  private let entryLifetime: TimeInterval
    
    // MARK: - Init

  init(dateProvider: @escaping () -> Date = Date.init,
       entryLifetime: TimeInterval = 3600) {
    self.dateProvider = dateProvider
    self.entryLifetime = entryLifetime
  }
  
    // MARK: - Methods

  func insert(_ value: Value, forKey key: Key) {
    let date = dateProvider().addingTimeInterval(entryLifetime)
    let entry = Entry(value: value, expirationDate: date)
    wrapped.setObject(entry, forKey: WrappedKey(key))
  }
  
  func value(forKey key: Key) -> Value? {
    guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
      return nil
    }
    
    guard dateProvider() < entry.expirationDate else {
      removeValue(forKey: key)
      return nil
    }
    
    return entry.value
  }
  
  func isExpired(forKey key: Key) -> Bool {
    guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
      return true
    }
    
    return dateProvider() > entry.expirationDate
  }
  
  private func removeValue(forKey key: Key) {
    wrapped.removeObject(forKey: WrappedKey(key))
  }
}

// MARK: - Extensions

private extension Cache {
  final class WrappedKey: NSObject {
    let key: Key
    
    init(_ key: Key) { self.key = key }
    
    override var hash: Int { return key.hashValue }
    
    override func isEqual(_ object: Any?) -> Bool {
      guard let value = object as? WrappedKey else {
        return false
      }
      return value.key == key
    }
  }
}

private extension Cache {
  final class Entry {
    let value: Value
    let expirationDate: Date
    
    init(value: Value, expirationDate: Date) {
      self.value = value
      self.expirationDate = expirationDate
    }
  }
}
