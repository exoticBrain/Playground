def bubble_sort(arr)
  i = 0
  loop do
    sorted = true
    for i in 0..(arr.size - 2)
      if arr[i] > arr[i+1]
        temp = arr[i]
        arr[i] = arr[i+1]
        arr[i+1] = temp
        sorted = false
      end
    end
    break if sorted
  end
  arr
end

p bubble_sort([4,3,-78,2,0,2])
# => [-78, 0, 2, 2, 3, 4]