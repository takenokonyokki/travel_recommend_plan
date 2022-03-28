class Move < ApplicationRecord

  has_many :contents

  enum name: { walk: 0, bicycle: 1, car: 2, taxi: 3, train: 4, bus: 5 }

end
