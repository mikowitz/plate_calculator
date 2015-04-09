class PlateCalculator
  PlateValues = [45, 35, 25, 10, 5, 2.5, 1.25]
  DefaultBarWeight = 45

  attr_reader :bar_wight, :available_plates

  def initialize(bar_weight=DefaultBarWeight)
    @bar_weight = bar_weight
    @available_plates = Hash[PlateValues.map{|v| [v, Float::INFINITY]}]
  end

  def set_plates(available_plate_hash)
    available_plate_hash.each do |weight, plate_count|
      set_plate_count(weight, plate_count)
    end
  end

  def set_plate_count(weight, plate_count)
    return unless PlateValues.include?(weight)
    @available_plates[weight] = plate_count
  end

  def plates_for(total_weight)
    plate_weight = total_weight.to_f - @bar_weight
    return error_hash(:lighter_than_bar) if plate_weight < 0
    return error_hash(:indivisible_by_current_plates) unless plate_weight % lowest_possible_division == 0
    plate_weight_per_side = plate_weight / 2.0
    plates = []
    @available_plates.each do |weight, plate_count|
      if plate_count == Float::INFINITY
        while plate_weight_per_side >= weight
          plates << weight
          plate_weight_per_side -= weight
        end
      else
        while plate_weight_per_side >= weight && plate_count > 0
          plates << weight
          plate_weight_per_side -= weight
          plate_count -= 1
        end
      end
    end
    plates
  end


  def error_hash(error_type)
    error_message = case error_type
                    when :lighter_than_bar
                      "You cannot load that weight with your current bar. Please use a lighter bar."
                    when :indivisible_by_current_plates
                      "You cannot load that weight with your current plates. Please select a total weight divisible by #{lowest_possible_division}"
                    end
    { error: error_message }
  end

  def lowest_possible_division
    @available_plates.select do |weight, plate_count|
      plate_count > 0
    end.map(&:first).sort.first * 2
  end
end
