---
title: Оформление подписки
sidebar_position: 2
---
# Сценарий оформления подписки

```plantuml

@startuml

left to right direction

actor "Пользователь" as u
actor "Служба поддержки" as s

package "Оформление подписки" {
usecase "Открыть раздел подписка" as UC1
usecase "Изучить условия подписки" as UC2
usecase "Выбрать тип подписки" as UC3
usecase "Задать вопрос поддержке" as UC4
usecase "Ввести данные для оплаты" as UC5
usecase "Ввести номер карты" as UC6
usecase "Ввести срок действия карты" as UC7
usecase "Ввести CVC-код" as UC8
usecase "Оплатить подписку" as UC9
usecase "Оформить подписку" as UC10
usecase "Отменить подписку" as UC11
usecase "Получить вопрос от клиента" as UC12
usecase "Ответить на вопрос клиента" as UC13
}

u --> UC1
u --> UC2
u --> UC3
UC2 <.. UC4: extend
u --> UC5
UC5 ..> UC6: include
UC5 ..> UC7: include
UC5 ..> UC8: include
u --> UC9
u --> UC10
UC10 <.. UC11: extend
s --> UC12
s --> UC13

@enduml


```

## Описание алгоритма

```plantuml

@startuml

actor Client
participant UI
participant Back
participant "Payment system" as ps

activate Client
Client -> UI: Узнать условия подписки
activate UI
Client <<-- UI: Условия подписки
deactivate UI
Client -> UI: Выбрать тип подписки
activate UI
UI -> Back: Зафиксировать выбор
activate Back
UI <<-- Back: Выбор зафиксирован
deactivate Back
Client <<-- UI: Тип подписки выбран
deactivate UI

Group Оплата подписки
Client -> UI: Ввести данные для оплаты
activate UI
UI -> Back: Данные для оплаты
activate Back
Back -> ps: Запрос платежа
activate ps
alt Платеж выполнен
Back <<-- ps: Платеж выполнен
deactivate ps
UI <<-- Back: Оплата прошла успешно
deactivate Back
Client <<-- UI: Подписка оформлена
else Платеж не выполнен
Back <<-- ps: Ошибка платежа
deactivate ps
UI <<-- Back: Оплата не прошла
deactivate Back
Client <<-- UI: Попробуйте снова
end
end

deactivate UI
deactivate Client

@enduml