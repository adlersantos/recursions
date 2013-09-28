# takes a start and an end and returns an array of all numbers between
def range(first, last)
  return [] if (last - first) <= 1
  last - first == 2 ? [first, last - 1] : [first + 1] + range(first + 1, last)
end

# takes an array of digits and sums all of the elements
def sum(nums)
  return 0 if nums.empty?
  nums[0] + sum_rec(nums[1..-1])
end

# exponent
def exp(base, power)
  (power == 0) ? 1 : (base * exp1(base, power - 1))
end

# performs a recursive dup for all interior arrays/elements of an array
class Array
  def deep_dup
    map { |el| el.is_a?(Array) ? el.dd_map : el }
  end
end

# returns the first n fibonacci numbers
def fibs(n)
  return [0] if n == 1
  return [0, 1] if n == 2
  fibs = fibs(n - 1)
  fibs << fibs[-2] + fibs[-1]
end

# recursive binary search
def bsearch(nums, target)
  return nil if nums.count == 0

  probe_index = nums.length / 2
  case target <=> nums[probe_index]
  when -1
    bsearch(nums.take(probe_index), target)
  when 0
    probe_index
  when 1
    sub_answer = bsearch(nums.drop(probe_index + 1), target)
    (sub_answer.nil?) ? nil : (probe_index + 1) + sub_answer
  end
end

# recursive binary search (boolean edition)
def bsearch(arr, item)
  middle = arr.count / 2
  return true if arr[middle] == item
  return false if arr.count < 2

  (item < arr[middle]) ? bsearch(arr[0...middle], item) : bsearch(arr[middle..-1], item)
end

# recursive merge sort
def merge_sort(array)
  return array if array.count < 2

  half_count = array.count / 2

  sorted_left = merge_sort(array.take(half_count))
  sorted_right = merge_sort(array.drop(half_count))

  merge(sorted_left, sorted_right)
end

# returns all subsets of an array
def subsets(array)
  if array.empty?
    return [[]]
  end

  el = array.shift[0]
  old_subsets = subsets(array)
  new_subsets = old_subsets.map { |old_subset| [el] + old_subset }
  new_subsets + old_subsets
end

# returns an array of the smallest number of coins that will total the amount
def make_change(amount, coins = [25, 10 ,5, 1])
  biggest_fit_coin = coins.detect { |val| amount >= val }

  if biggest_fit_coin == amount
    [biggest_fit_coin]
  else
    [biggest_fit_coin] + make_change(amount - biggest_fit_coin)
  end
end

# Suppose a hash represents a directory with subdirectories and so on.
# If a key is a directory, it points to a subhash. If a key is a file, it points to true.
# The function below returns an array of strings representing the file paths to each file
# in the hash.
def file_paths(file_tree, paths_so_far = "")
  paths = []
  file_tree.keys.each do |key|
    if file_tree[key] == true
      paths << paths_so_far += "/#{key}"
    else
      paths_so_far += "/#{key}"
      paths += paths(file_tree[key], paths_so_far)
    end
  end
  paths
end
