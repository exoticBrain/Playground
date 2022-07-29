def stock_picker(prices)
    min_price = prices[0]
    min_index = 0

    profit = 0
    days = [0,0]
    prices.each_with_index do |price, i|
        if price < min_price
            min_price = price
            min_index = i
            next
        end

        best_profit = price - min_price
        if best_profit > profit
            profit = best_profit
            days = [min_index, i]
        end
    end
    days
end

stock_picker([17,3,6,9,15,8,6,1,10])
# => [1, 4]