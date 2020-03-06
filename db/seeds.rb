User.find_or_create_by!(email: 'admin@gidroiz.ru') do |user|
  user.name = 'gidroiz'
  user.password = 'gidroiz00'
  user.password_confirmation = 'gidroiz00'
  user.admin!
end

User.find_or_create_by!(email: 'manager@gidroiz.ru') do |user|
  user.name = 'manager'
  user.password = 'gidroiz01'
  user.password_confirmation = 'gidroiz01'
  user.manager!
end

EmployeeStatus.find_or_create_by!(name: 'Кандидат')
EmployeeStatus.find_or_create_by!(name: 'Работает')
EmployeeStatus.find_or_create_by!(name: 'Уволен')
EmployeeStatus.find_or_create_by!(name: 'Уволен не нанимать')

SalaryPeriod.find_or_create_by!(name: 'с 1 по 15 число')
SalaryPeriod.find_or_create_by!(name: 'с 16 по 31 число')

PaymentType.find_or_create_by!(name: 'Сдельная')
PaymentType.find_or_create_by!(name: 'Почасовая')

FireReason.find_or_create_by!(name: 'За пьянку')
FireReason.find_or_create_by!(name: 'За прогулы')
FireReason.find_or_create_by!(name: 'Плохо работал')
FireReason.find_or_create_by!(name: 'За не выход')

Position.find_or_create_by!(name: 'Руководитель')
Position.find_or_create_by!(name: 'Директор')
Position.find_or_create_by!(name: 'Рабочий')
Position.find_or_create_by!(name: 'Менеджер')
Position.find_or_create_by!(name: 'Кладовщик')
Position.find_or_create_by!(name: 'Прораб')

Employee.find_or_create_by!(last_name: 'Белов') do |emp|
  emp.first_name = 'Алексей'
  emp.position = Position.find_by(name: 'Руководитель')
  emp.employee_status = EmployeeStatus.find_by(name: 'Работает')
end

DailyTimesheetStatus.find_or_create_by!(name: 'Черновик', color: 'red')
DailyTimesheetStatus.find_or_create_by!(name: 'Открыт', color: 'yellow')
DailyTimesheetStatus.find_or_create_by!(name: 'Закрыт', color: 'green')

FacilityStatus.find_or_create_by!(name: 'Перспективный')
FacilityStatus.find_or_create_by!(name: 'Текущий')
FacilityStatus.find_or_create_by!(name: 'Завершен')
FacilityStatus.find_or_create_by!(name: 'Ремонт')

LeadStatus.find_or_create_by!(name: 'Нахождение объекта')
LeadStatus.find_or_create_by!(name: 'Определение потребности, общение с первичным человеком,  проявление интереса')
LeadStatus.find_or_create_by!(name: 'Определение лица принимающего решения')
LeadStatus.find_or_create_by!(name: 'Назначение встречи')
LeadStatus.find_or_create_by!(name: 'Встреча, проявление интереса')
LeadStatus.find_or_create_by!(name: 'Получение технического задания')
LeadStatus.find_or_create_by!(name: 'Подготовка коммерческого предложения')
LeadStatus.find_or_create_by!(name: 'Утверждение условий')
LeadStatus.find_or_create_by!(name: 'Подписания договора')
LeadStatus.find_or_create_by!(name: 'Получение аванса')
LeadStatus.find_or_create_by!(name: 'Выполняется')
LeadStatus.find_or_create_by!(name: 'Выполнен')
LeadStatus.find_or_create_by!(name: 'Закончен, оплачен')
LeadStatus.find_or_create_by!(name: 'Долг')

LeadConstructionType.find_or_create_by!(name: 'Подвал / цоколь')
LeadConstructionType.find_or_create_by!(name: 'Стены')
LeadConstructionType.find_or_create_by!(name: 'Плита пола')
LeadConstructionType.find_or_create_by!(name: 'Санузел')
LeadConstructionType.find_or_create_by!(name: 'Кровля')
LeadConstructionType.find_or_create_by!(name: 'Балкон')

LeadType.find_or_create_by!(name: 'Жилой дом')
LeadType.find_or_create_by!(name: 'Коммерческая недвижимость')
LeadType.find_or_create_by!(name: 'Паркинг')
LeadType.find_or_create_by!(name: 'Многоквартирный дом / жилой комплекс')
LeadType.find_or_create_by!(name: 'Гараж')

LeadPaymentStatus.find_or_create_by!(name: 'Ждем аванс')
LeadPaymentStatus.find_or_create_by!(name: 'Аванс заплачен')
LeadPaymentStatus.find_or_create_by!(name: 'Оплата')
LeadPaymentStatus.find_or_create_by!(name: 'Оплачено')
LeadPaymentStatus.find_or_create_by!(name: 'Долг')

TaskStatus.find_or_create_by!(title: 'Назначено')
TaskStatus.find_or_create_by!(title: 'В исполнении')
TaskStatus.find_or_create_by!(title: 'Исполнено')

ExpenseCategory.find_or_create_by!(name: 'Проездные расходы')
ExpenseCategory.find_or_create_by!(name: 'Накладные расходы')
ExpenseCategory.find_or_create_by!(name: 'Топливные расходы')
ExpenseCategory.find_or_create_by!(name: 'Другие расходы')
ExpenseCategory.find_or_create_by!(name: 'Приход')

AdocStatus.find_or_create_by!(name: 'готово/возвращены', color: '#99CC00', order: 10)
AdocStatus.find_or_create_by!(name: 'нет документа', color: '#FFFF00', order: 20)
AdocStatus.find_or_create_by!(name: 'нет необходимости', color: '#000000', order: 30)
AdocStatus.find_or_create_by!(name: 'необходимо', color: '#FF00FF', order: 40)
AdocStatus.find_or_create_by!(name: 'в стадии выполнения', color: '#CCFFFF', order: 50)
AdocStatus.find_or_create_by!(name: 'в стадии завершения', color: '#CCFFCC', order: 60)
AdocStatus.find_or_create_by!(name: 'проверка/корректировка', color: '#FFFF99', order: 70)
AdocStatus.find_or_create_by!(name: 'распечатка', color: '#FFCC99', order: 80)
AdocStatus.find_or_create_by!(name: 'на подписи/печати у нас', color: '#FFFF00', order: 90)
AdocStatus.find_or_create_by!(name: 'на подписи/печати у заказчика', color: '#00FF00', order: 100)
AdocStatus.find_or_create_by!(name: 'внимание/срочно', color: '#FF0000', order: 110)
AdocStatus.find_or_create_by!(name: 'уточнить нужен или нет', color: '#3399FF', order: 120)
AdocStatus.find_or_create_by!(name: 'завершено', color: '#996600', order: 130)
AdocStatus.find_or_create_by!(name: 'не знаю ', color: '#FFCC00', order: 140)

AdocName.find_or_create_by!(name: 'Акт продление сроков')
AdocName.find_or_create_by!(name: 'Смета')
AdocName.find_or_create_by!(name: 'Дополнительное соглашение')
AdocName.find_or_create_by!(name: 'График производства работ')
AdocName.find_or_create_by!(name: 'Тех карта/регламент')
AdocName.find_or_create_by!(name: 'Чертеж/план схема')
AdocName.find_or_create_by!(name: 'Наши узлы')
AdocName.find_or_create_by!(name: 'Форма для склада')
AdocName.find_or_create_by!(name: 'Смета (ИП)')
AdocName.find_or_create_by!(name: 'Приказы ответственных лиц')
AdocName.find_or_create_by!(name: 'Журнал ТБ, вводный инструктаж')
AdocName.find_or_create_by!(name: 'Сокращенный график работ')
AdocName.find_or_create_by!(name: 'Акт приема передачи СП')
AdocName.find_or_create_by!(name: 'Журнал производства работ')
AdocName.find_or_create_by!(name: 'КС-1')
AdocName.find_or_create_by!(name: 'КС-2')
AdocName.find_or_create_by!(name: 'КС-3')
AdocName.find_or_create_by!(name: 'КС-4')
AdocName.find_or_create_by!(name: 'КС-5')
AdocName.find_or_create_by!(name: 'КС-6')
AdocName.find_or_create_by!(name: 'Акт выполненных работ (ИП) без НДС')
AdocName.find_or_create_by!(name: 'Счёт-фактура')
AdocName.find_or_create_by!(name: 'АОСР/сертификаты на материалы')
AdocName.find_or_create_by!(name: 'Исполнительная')
AdocName.find_or_create_by!(name: 'Акт законченного строительства')
AdocName.find_or_create_by!(name: 'Реестр сданных документов')
AdocName.find_or_create_by!(name: 'Материальный отчет')
AdocName.find_or_create_by!(name: 'Отчет о списании давальческих материалов')
AdocName.find_or_create_by!(name: 'Акт гарантийного ремонта')

DeliveryPaymentStatus.find_or_create_by!(name: 'Запрос')
DeliveryPaymentStatus.find_or_create_by!(name: 'Счет')
DeliveryPaymentStatus.find_or_create_by!(name: 'Оплата')
DeliveryPaymentStatus.find_or_create_by!(name: 'Оплачено')

DeliveryStatus.find_or_create_by!(name: 'Запрос цены')
DeliveryStatus.find_or_create_by!(name: 'Счет')
DeliveryStatus.find_or_create_by!(name: 'Оплата')
DeliveryStatus.find_or_create_by!(name: 'Оплачено')
DeliveryStatus.find_or_create_by!(name: 'В пути')
DeliveryStatus.find_or_create_by!(name: 'Прибыл')
DeliveryStatus.find_or_create_by!(name: 'Получено')

DeliveryDocument.find_or_create_by!(name: 'Счет фактура и накладная')
DeliveryDocument.find_or_create_by!(name: 'Накладная')
DeliveryDocument.find_or_create_by!(name: 'Чек')

DeliveryDest.find_or_create_by!(name: 'Склад')
DeliveryDest.find_or_create_by!(name: 'Офис')
DeliveryDest.find_or_create_by!(name: 'Производство')

CommodityType.find_or_create_by!(name: 'Инструменты')
CommodityType.find_or_create_by!(name: 'Инвентарь')
CommodityType.find_or_create_by!(name: 'Материал')
CommodityType.find_or_create_by!(name: 'Расходники')
CommodityType.find_or_create_by!(name: 'Тара')
CommodityType.find_or_create_by!(name: 'СИЗ')

TaskStatus.find_or_create_by!(title: 'Важно', order: 20)
TaskStatus.find_or_create_by!(title: 'Срочно', order: 10)
