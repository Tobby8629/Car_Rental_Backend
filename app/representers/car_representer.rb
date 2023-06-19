class CarRepresenter
  def initialize(car)
    @car = car
  end

  def as_json
    {
      id: car.id,
      name: car.name,
      description: car.description,
      photo: rails_blob_url(car.photo),
      price: car.price,
      model: car.model,
      user_id: car.user_id,
      username: car.user.username
    }
  end

  private

  attr_reader :car
end
