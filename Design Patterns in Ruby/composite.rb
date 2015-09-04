class Task
  attr_accessor :name, :parent
  
  def initialize(name)
    @name = name
	@parent = nil
  end
  
  def get_time_required
    0.0
  end
  
  def total_number_basic_tasks
    1
  end
end

class CompositeTask < Task
  def initialize(name)
    super(name)
	@sub_tasks = []
  end
  
  def add_sub_task(task)
    @sub_tasks << task
	task.parent = self
  end
  
  def remove_sub_task(task)
    @sub_tasks.delete(task)
	task.parent = nil
  end
  
  def get_time_required
    time = 0.0
	@sub_tasks.each {|task| time += task.get_time_required}
	time
  end
  
  def total_number_basic_tasks
    total = 0
	@sub_tasks.each {|task| total += task.total_number_basic_tasks}
	total
  end
end

class AddDryIngredientsTask < Task
  
  def initialize
    super('Dodaj suche składniki')
  end
  
  def get_time_required
    1.0
  end
end

class AddLiquidTask < Task
  
  def initialize
    super('Dodaj wodę i mleko')
  end
  
  def get_time_required
    1.0
  end
end

class MixTask < Task
  
  def initialize
    super('Wymieszaj masę!')
  end
  
  def get_time_required
    3.0
  end
end

class FillPanTask < Task
  
  def initialize
    super('Wypełnij brytfankę ciastem')
  end
  
  def get_time_required
    4.0
  end
end

class BakeTask < Task

  def initialize
    super('Upiecz masę z brytfanki')
  end
  
  def get_time_required
    10.0
  end
end

class FrostTask < Task
  
  def initialize  
    super('Ostudź i wsadź do zamrażalnika gotowe ciasto')
  end
  
  def get_time_required
    30.0
  end
end

class LickSpoonTask < Task

  def initialize
    super('Skosztuj ciasta pozostałego na użytej łyżeczce')
  end
  
  def get_time_required
    0.1
  end
end

class MakeBatterTask < CompositeTask
  
  def initialize
    super('Przygotuj masę')
	@sub_tasks = []
	add_sub_task(AddDryIngredientsTask.new)
	add_sub_task(AddLiquidTask.new)
	add_sub_task(MixTask.new)
  end
end

class MakeCakeTask < CompositeTask
  
  def initialize
    super('Upiecz ciasto')
	add_sub_task(MakeBatterTask.new)
	add_sub_task(FillPanTask.new)
	add_sub_task(BakeTask.new)
	add_sub_task(FrostTask.new)
    add_sub_task(LickSpoonTask.new)
  end
end

