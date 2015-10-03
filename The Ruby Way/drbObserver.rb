module DRbObservable

  def add_observer(observer)
    @observer_peers ||= []
	unless observer.respond_to? :update
	  raise NameError, "obserwator musi odpowiadać na żądanie aktualizacji"
	end
	@observer_peers.push observer
  end
  
  def delete_observer(observer)
    @observer_peers.delete observer if defined? @observer_peers
  end
  
  def notify_observers(*args)
    return unless defined? @observer_peers
	for i in @observer_peers.dup
	  begin
	    i.update(*args)
	  rescue
	    delete_observer(i)
	  end
	end
  end
end