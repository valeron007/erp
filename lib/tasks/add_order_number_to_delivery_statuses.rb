ActiveRecord::Base.transaction do
  DeliveryStatus.find_by_name("Олачено").destroy
  DeliveryStatus.first_or_create(name: "Товар получен, документы в процессе")

  arr = ["Запрос цены",
         "Счет",
         "Оплата",
         "Оплачено",
         "В пути",
         "Прибыл",
         "Товар получен, документы в процессе",
         "Получено"]

  arr.each.with_index(1) do |element, index|
    DeliveryStatus.find_by_name(element).update_attributes(order_number: index)
  end
end