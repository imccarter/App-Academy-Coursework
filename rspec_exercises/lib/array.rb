class Array
  def my_uniq
    uniq_arr = []
    self.each do |el|
      uniq_arr << el unless uniq_arr.include?(el)
    end
    uniq_arr
  end

  def two_sum
    sum_pos = []

    each_with_index do |x, idx|
      i = idx + 1
      while i < length
        sum_pos << [idx, i] if x + self[i] == 0
        i += 1
      end
    end

    sum_pos.length > 0 ? sum_pos : nil
  end

  def median
    sorted = self.sort

    if empty?
      nil
    elsif length.odd?
      sorted[length / 2]
    else
      (sorted[(length / 2) - 1] + sorted[length / 2]) / 2
    end
  end

  def my_transpose
    if self.any? { |row| row.length != self[0].length }
      return nil
    elsif self[0].empty?
      return self
    end

    transposed = []

    each_index do |r_idx|
      new_row = []
      each_index do |c_idx|
        new_row << self[c_idx][r_idx]
      end
      new_row.compact!
      if new_row.length > 0
        transposed << new_row
      end
    end

    transposed
  end

end
