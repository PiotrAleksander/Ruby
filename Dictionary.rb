module Dict
  def Dict.new(num_buckets=256)
    # Initializuje słownik z określoną liczbą wiaderek
    aDict = []
    (0...num_buckets).each do |i|
      aDict.push([])
    end

    return aDict
  end

  def Dict.hash_key(aDict, key)
    #Przekonwertuje dany klucz
    # na indeks dla słownikowego wiaderka
    return key.hash % aDict.length
  end

  def Dict.get_bucket(aDict, key)
    # Szuka wiaderka według podanego klucza
    bucket_id = Dict.hash_key(aDict, key)
    return aDict[bucket_id]
  end

  def Dict.get_slot(aDict, key, default=nil)
    # Zwraca indeks, klucz i wartość wiaderka znalezionego po kluczu
    bucket = Dict.get_bucket(aDict, key)

    bucket.each_with_index do |kv, i|
      k, v = kv
      if key == k
        return i, k, v
      end
    end

    return -1, key, default
  end

  def Dict.get(aDict, key, default=nil)
    #Wyciąga wartość z wiaderka danego klucza, albo default
    i, k, v = Dict.get_slot(aDict, key, default=default)
    return v
  end

  def Dict.set(aDict, key, value)
    # Ustanawia nową wartość dla podanego klucza
    bucket = Dict.get_bucket(aDict, key)
    i, k, v = Dict.get_slot(aDict, key)

    if i >= 0 #sprawdza, czy klucz istnieje
      bucket[i] = [key, value]
    else #jeżeli nie, dodaje go razem z wartością
      bucket.push([key, value])
    end
  end

  def Dict.delete(aDict, key)
    # Usuwa podany klucz ze słownika
    bucket = Dict.get_bucket(aDict, key)

    (0...bucket.length).each do |i|
      k, v = bucket[i]
      if key == k
        bucket.delete_at(i)
        break
      end
    end
  end

  def Dict.list(aDict)
    # Drukuje wiaderka ze słownika
    aDict.each do |bucket|
      if bucket
        bucket.each {|k, v| puts k, v}
      end
    end
  end
end