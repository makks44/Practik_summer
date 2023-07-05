class PersonAlreadyExist < StandardError
    def initialize(inn)
      message = "Person with INN #{inn} already exists"
      super(message)
    end
  end
  
  class PersonNotFoundError < StandardError
    def initialize(inn)
      message = "Person with INN #{inn} not found"
      super(message)
    end
  end
  