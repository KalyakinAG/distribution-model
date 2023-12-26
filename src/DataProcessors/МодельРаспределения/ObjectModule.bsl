//@skip-check module-unused-method
//@skip-check object-module-export-variable
//@skip-check module-accessibility-at-client

//  Подсистема "Модель распределения"
//	Автор: Калякин Андрей Г.
//  https://github.com/KalyakinAG/distribution-model
//  https://infostart.ru/public/1620797/

#Область ОписаниеПеременных

Перем 
	Схема Экспорт,
	МенеджерВременныхТаблиц Экспорт,
	ВидРаспределения Экспорт,
	Точность Экспорт,
	ВыполненоРаспределение Экспорт,
	ИтераторТаблицы Экспорт,
	ИтераторОтношения Экспорт,
	ИтераторБазы Экспорт
;

Перем
	ТаблицаРаспределения Экспорт,
	ТаблицаОтношения Экспорт,
	БазаРаспределения Экспорт,
	РезультатРаспределения Экспорт,
	СтрокаРезультата Экспорт
;

Перем //  Описание источника: Таблица, Отношение, База и тип поля: Измерения, Ресурсы, Реквизиты
	Источник,
	ТипПоля,
	ТипИсточника
;

Перем //  Переменные состояния распределения 
	Стек,
	ТекущийУровень,
	МаксУровень,
	ТребуетсяПропорция,
	ДопРесурсы,
	ЕстьДопРесурсыТаблицы,
	ЕстьДопРесурсыБазы,
	СтрокаРесурсовБазы,
	ПолеРаспределения
;

Перем ВидыРаспределения;

#КонецОбласти

#Область ПрограммныйИнтерфейс

Функция Полное() Экспорт
	Схема.Вставить("ВидРаспределения", ВидыРаспределения.Полное);
	Возврат ЭтотОбъект;
КонецФункции

Функция ПоБазе() Экспорт
	Схема.Вставить("ВидРаспределения", ВидыРаспределения.ПоБазе);
	Возврат ЭтотОбъект;
КонецФункции

Функция ПоПорядку() Экспорт
	Схема.Вставить("ВидРаспределения", ВидыРаспределения.ПоПорядку);
	Возврат ЭтотОбъект;
КонецФункции

Функция Точность(Значение) Экспорт
	Точность = Значение;
	Возврат ЭтотОбъект;
КонецФункции

Функция ВидРаспределения(Знач Вид) Экспорт
	ВидРаспределения = ВидыРаспределения[Вид];
	Если ВидРаспределения = ВидыРаспределения.ПоПорядку Тогда
		Возврат ПоПорядку();
	ИначеЕсли ВидРаспределения = ВидыРаспределения.ПоБазе Тогда
		Возврат ПоБазе();
	ИначеЕсли ВидРаспределения = ВидыРаспределения.Полное Тогда
		Возврат Полное();
	КонецЕсли;
	Возврат ЭтотОбъект;
КонецФункции

Функция УстановитьМенеджерВременныхТаблиц(НовыйМенеджерВременныхТаблиц) Экспорт
	МенеджерВременныхТаблиц = НовыйМенеджерВременныхТаблиц;
	Возврат ЭтотОбъект;
КонецФункции

Функция Таблица(ИмяИсточника, Псевдоним = "") Экспорт
	Если ВыполненоРаспределение Тогда
		Очистить();
	КонецЕсли;
	ТипИсточника = "Таблица";
	Источник = ДобавитьИсточникМодели(ТипИсточника, ИмяИсточника, Псевдоним);
	Возврат ЭтотОбъект;
КонецФункции

Функция Отношение(ИмяИсточника, Псевдоним = Неопределено) Экспорт
	Если ВыполненоРаспределение Тогда
		Очистить();
	КонецЕсли;
	ТипИсточника = "Отношение";
	Источник = ДобавитьИсточникМодели(ТипИсточника, ИмяИсточника, Псевдоним);
	Возврат ЭтотОбъект;
КонецФункции

Функция База(ИмяИсточника, Псевдоним = Неопределено) Экспорт
	Если ВыполненоРаспределение Тогда
		Очистить();
	КонецЕсли;
	ТипИсточника = "База";
	Источник = ДобавитьИсточникМодели(ТипИсточника, ИмяИсточника, Псевдоним);
	Возврат ЭтотОбъект;
КонецФункции

Функция ИзмеренияТаблицы() Экспорт
	ТипПоля = "ИзмеренияТаблицы";
	Источник.Вставить(ТипПоля, Новый Массив);
	Возврат ЭтотОбъект;
КонецФункции

Функция ИзмеренияБазы() Экспорт
	ТипПоля = "ИзмеренияБазы";
	Источник.Вставить(ТипПоля, Новый Массив);
	Возврат ЭтотОбъект;
КонецФункции

Функция Измерения() Экспорт
	ТипПоля = "Измерения";
	Источник.Вставить(ТипПоля, Новый Массив);
	Возврат ЭтотОбъект;
КонецФункции

Функция Ресурсы() Экспорт
	ТипПоля = "Ресурсы";
	Источник.Вставить(ТипПоля, Новый Массив);
	Возврат ЭтотОбъект;
КонецФункции

Функция Реквизиты() Экспорт
	ТипПоля = "Реквизиты";
	Источник.Вставить(ТипПоля, Новый Массив);
	Возврат ЭтотОбъект;
КонецФункции

// Поле
// 
// Параметры:
//  Поле - Строка - Поле
//  ПсевдонимИсходный - Строка - Псевдоним исходный
// 
// Возвращаемое значение:
//  ОбработкаОбъект.МодельРаспределения -- Поле
Функция Поле(Поле, ПсевдонимИсходный = "") Экспорт
	Перем Поля;
	Если Поле = "*" Тогда
		Если ТипПоля = "Реквизиты" Тогда
			// знак "*" для поля Реквизиты или для Таблицы означает выборку всех еще не задействованных полей источника
			Источник.Реквизиты.Добавить(СтруктураПоля("*"));
			Возврат ЭтотОбъект;
		КонецЕсли;
		//  Измерения таблицы
		Если ТипИсточника = "Таблица" Тогда
			ВызватьИсключение "Нельзя использовать '*' для описания полей измерений таблицы";
		КонецЕсли;
		//  Измерения отношения
		Если ТипИсточника = "Отношение" Тогда
			Если ТипПоля = "ИзмеренияБазы" Тогда
				ВызватьИсключение "Нельзя использовать '*' для описания полей измерений базы в отношении";
			КонецЕсли;
			Если ТипПоля = "ИзмеренияТаблицы" Тогда
				Если Схема.Таблица.Свойство("Измерения", Поля) Тогда
					Для Каждого _Поле Из Поля Цикл
						Поле(_Поле.Псевдоним);
					КонецЦикла;
				КонецЕсли;
			КонецЕсли;
			Если Схема.Таблица.Свойство(ТипПоля, Поля) Тогда
				Для Каждого _Поле Из Поля Цикл
					Поле(_Поле.Псевдоним);
				КонецЦикла;
			КонецЕсли;
			Возврат ЭтотОбъект;
		КонецЕсли;
		//  Измерения Базы из Отношения
		Если ТипПоля = "Измерения" И Схема.Свойство("Отношение") Тогда
			Если Схема.Отношение.Свойство("ИзмеренияБазы", Поля) Тогда
				Для Каждого _Поле Из Поля Цикл
					Поле(_Поле.Псевдоним);
				КонецЦикла;
			КонецЕсли;
			Возврат ЭтотОбъект;
		КонецЕсли;
		//  Измерения Базы из Таблицы		
		Если Схема.Таблица.Свойство(ТипПоля, Поля) Тогда
			Для Каждого _Поле Из Поля Цикл
				Поле(_Поле.Псевдоним);
			КонецЦикла;
		КонецЕсли;
		Возврат ЭтотОбъект;
	КонецЕсли;
	
	Если ПустаяСтрока(ПсевдонимИсходный) Тогда
		Псевдоним = ОбщийКлиентСервер.ОкончаниеСтрокиПослеРазделителя(Поле);
	Иначе
		Псевдоним = ПсевдонимИсходный;
	КонецЕсли;
	Источник[ТипПоля].Добавить(СтруктураПоля(Поле, Псевдоним));
	Возврат ЭтотОбъект;
КонецФункции

Функция Отбор(Выражение) Экспорт
	Источник.Отбор.Добавить(Выражение);
	Возврат ЭтотОбъект;
КонецФункции

// Порядок
// 
// Параметры:
//  Выражение - Строка - Выражение
//  Направление - Неопределено, Строка, НаправлениеПорядкаСхемыЗапроса - Направление
// 
// Возвращаемое значение:
//  ОбработкаОбъект.МодельРаспределения - Порядок
Функция Порядок(Выражение, Направление = Неопределено) Экспорт
	Если ТипЗнч(Направление) = Тип("Строка") Тогда
		Если Направление = "-" Тогда
			Источник.Порядок.Добавить(Новый Структура("Выражение, Направление", Выражение, НаправлениеПорядкаСхемыЗапроса.ПоУбыванию));
			Возврат ЭтотОбъект;
		КонецЕсли;
		Если Направление = "+" Тогда
			Источник.Порядок.Добавить(Новый Структура("Выражение, Направление", Выражение, НаправлениеПорядкаСхемыЗапроса.ПоВозрастанию));
			Возврат ЭтотОбъект;
		КонецЕсли;
		Источник.Порядок.Добавить(Новый Структура("Выражение, Направление", Выражение, НаправлениеПорядкаСхемыЗапроса[Направление]));
		Возврат ЭтотОбъект;
	КонецЕсли;				
	Источник.Порядок.Добавить(Новый Структура("Выражение, Направление", Выражение, Направление));
	Возврат ЭтотОбъект;
КонецФункции

Функция Автопорядок() Экспорт
	Источник.Автопорядок = Истина;
	Возврат ЭтотОбъект;
КонецФункции

#Область АлгоритмРаспределения

Функция СоздатьИтератор(Таблица, ВедущийИтератор = Неопределено, ВедущиеПоля = Неопределено)
	Итератор = Новый Структура;
	Итератор.Вставить("Таблица", Таблица);
	Итератор.Вставить("ВедущийИтератор", ВедущийИтератор);
	Итератор.Вставить("ВедущиеПоля", ВедущиеПоля);
	Итератор.Вставить("Индекс", -1);
	Итератор.Вставить("Строки", Неопределено);
	Итератор.Вставить("ТекущиеДанные", Неопределено);
	Итератор.Вставить("Количество", Неопределено);
	Возврат Итератор;
КонецФункции

Процедура СкопироватьКолонки(КолонкиПолучателя, КолонкиИсточника, Поля)
	Для Каждого Поле Из Поля Цикл
		ИмяПоля = Поле.Псевдоним;
		Если Поле.Поле = "*" Тогда
			ПоляРазвернуто = РаботаСМассивом.Отобразить(КолонкиИсточника, "Новый Структура('Поле, Псевдоним', Элемент.Имя, Элемент.Имя)");
			СкопироватьКолонки(КолонкиПолучателя, КолонкиИсточника, ПоляРазвернуто);
			Продолжить;
		КонецЕсли;
		Если КолонкиПолучателя.Найти(ИмяПоля) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		КолонкиПолучателя.Добавить(ИмяПоля, Новый ОписаниеТипов(КолонкиИсточника[ИмяПоля].ТипЗначения, , "NULL"));
	КонецЦикла;
КонецПроцедуры

Процедура Инициализировать() Экспорт
	ЕстьОтношение = Схема.Свойство("Отношение");
	МодельЗапроса = Общий.МодельЗапроса(МенеджерВременныхТаблиц);
	ДобавитьЗапросИсточника(МодельЗапроса, "Таблица");
	Если ЕстьОтношение Тогда
		ДобавитьЗапросИсточника(МодельЗапроса, "Отношение");
	КонецЕсли;
	ДобавитьЗапросИсточника(МодельЗапроса, "База");
	МодельЗапроса.ВыполнитьЗапрос();
	ТаблицаРаспределения = МодельЗапроса.ВыгрузитьРезультат("Таблица");
	БазаРаспределения = МодельЗапроса.ВыгрузитьРезультат("База");
	Если ЕстьОтношение Тогда
		ТаблицаОтношения = МодельЗапроса.ВыгрузитьРезультат("Отношение");
	Иначе
		ТаблицаОтношения = Неопределено;
	КонецЕсли;
	//  ВидРаспределения
	Если НЕ Схема.Свойство("ВидРаспределения", ВидРаспределения) Тогда
		Если Схема.База.Свойство("Порядок") И ЗначениеЗаполнено(Схема.База.Порядок) Тогда
			ВидРаспределения = ВидыРаспределения.ПоПорядку;
		Иначе
			Ресурс = Схема.Таблица.Ресурсы[0].Псевдоним;
			Если ТаблицаРаспределения.Итог(Ресурс) > БазаРаспределения.Итог(Ресурс) Тогда
				ВидРаспределения = ВидыРаспределения.Полное;
			Иначе
				ВидРаспределения = ВидыРаспределения.ПоБазе;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	ТребуетсяПропорция = ВидРаспределения <> ВидыРаспределения.ПоПорядку;
	РесурсыТаблицы = РаботаСМассивом.Отобразить(Схема.Таблица.Ресурсы, "Элемент.Псевдоним");
	РесурсыБазы = РаботаСМассивом.Отобразить(Схема.База.Ресурсы, "Элемент.Псевдоним");
	ПолеРаспределения = РесурсыБазы[0];
	ЕстьДопРесурсыТаблицы = Схема.Таблица.Ресурсы.ВГраница() > 0;
	ЕстьДопРесурсыБазы = Схема.База.Ресурсы.ВГраница() > 0;
	ЕстьДопРесурсы = ЕстьДопРесурсыТаблицы ИЛИ ЕстьДопРесурсыБазы;
	ДопРесурсы = Новый Массив;
	Если ЕстьДопРесурсыТаблицы Тогда
		Ресурсы = Схема.Таблица.Ресурсы;
		Для й = 1 По Ресурсы.ВГраница() Цикл
			ДопРесурсы.Добавить(Ресурсы[й].Псевдоним);
		КонецЦикла;
	ИначеЕсли ЕстьДопРесурсыБазы Тогда
		Ресурсы = Схема.База.Ресурсы;
		Для й = 1 По Ресурсы.ВГраница() Цикл
			ДопРесурсы.Добавить(Ресурсы[й].Псевдоним);
		КонецЦикла;
	КонецЕсли;
	СтрокаРесурсовБазы = СтрСоединить(РесурсыБазы, ",");
	
	//  Результат распределения
	РезультатРаспределения = Новый ТаблицаЗначений;
	СкопироватьКолонки(РезультатРаспределения.Колонки, БазаРаспределения.Колонки, Схема.База.Измерения);
	СкопироватьКолонки(РезультатРаспределения.Колонки, БазаРаспределения.Колонки, Схема.База.Ресурсы);
	СкопироватьКолонки(РезультатРаспределения.Колонки, БазаРаспределения.Колонки, Схема.База.Реквизиты);
	СкопироватьКолонки(РезультатРаспределения.Колонки, ТаблицаРаспределения.Колонки, Схема.Таблица.Измерения);
	СкопироватьКолонки(РезультатРаспределения.Колонки, ТаблицаРаспределения.Колонки, Схема.Таблица.Ресурсы);
	СкопироватьКолонки(РезультатРаспределения.Колонки, ТаблицаРаспределения.Колонки, Схема.Таблица.Реквизиты);
	
	ИтераторТаблицы = СоздатьИтератор(ТаблицаРаспределения);
	Стек = Новый Массив;
	Стек.Добавить(ИтераторТаблицы);
	Если ЕстьОтношение Тогда
		ИтераторОтношения = СоздатьИтератор(ТаблицаОтношения, ИтераторТаблицы, СтрСоединить(РаботаСМассивом.Отобразить(Схема.Отношение.ИзмеренияТаблицы, "Элемент.Псевдоним"), ","));
		ИтераторБазы = СоздатьИтератор(БазаРаспределения, ИтераторОтношения, СтрСоединить(РаботаСМассивом.Отобразить(Схема.Отношение.ИзмеренияБазы, "Элемент.Псевдоним"), ","));
		ИтераторБазы.Вставить("Итоги", Новый Структура(СтрокаРесурсовБазы));
		Стек.Добавить(ИтераторОтношения);
	Иначе
		ИтераторОтношения = Неопределено;
		ИтераторБазы = СоздатьИтератор(БазаРаспределения, ИтераторТаблицы, СтрСоединить(РаботаСМассивом.Отобразить(Схема.База.Измерения, "Элемент.Псевдоним"), ","));
		ИтераторБазы.Вставить("Итоги", Новый Структура(СтрокаРесурсовБазы));
	КонецЕсли;
	Стек.Добавить(ИтераторБазы);
	ИтераторБазы.Вставить("Итоги", Новый Структура(СтрокаРесурсовБазы));

	МаксУровень = Стек.ВГраница();
	ТекущийУровень = 0;
	
	ВыполненоРаспределение = Истина;
КонецПроцедуры

Процедура Сбросить() Экспорт
	Стек = Неопределено;
КонецПроцедуры

Функция СледующийЭлемент(Итератор)
	Если Итератор.Индекс = -1 Тогда
		ВедущийИтератор = Итератор.ВедущийИтератор;
		Если ВедущийИтератор = Неопределено ИЛИ НЕ ЗначениеЗаполнено(Итератор.ВедущиеПоля) Тогда
			ОтобранныеСтроки = Итератор.Таблица;
		Иначе
			Отбор = Новый Структура(Итератор.ВедущиеПоля);
			ЗаполнитьЗначенияСвойств(Отбор, ВедущийИтератор.ТекущиеДанные);
			ОтобранныеСтроки = Итератор.Таблица.НайтиСтроки(Отбор);
		КонецЕсли;
		Итератор.Строки = ОтобранныеСтроки;
		Итератор.Количество = ОтобранныеСтроки.Количество();
	КонецЕсли;
	Индекс = Итератор.Индекс + 1;
	Если Индекс = Итератор.Количество Тогда
		Итератор.Индекс = -1;
		Итератор.ТекущиеДанные = Неопределено;
		Возврат Ложь;
	КонецЕсли;
	Итератор.Индекс = Индекс;
	Итератор.ТекущиеДанные = Итератор.Строки[Индекс];
	Возврат Истина;
КонецФункции

Функция Следующий() Экспорт
	Если НЕ ЗначениеЗаполнено(Стек) Тогда
		Инициализировать();
	КонецЕсли;
	Если СтрокаРезультата <> Неопределено Тогда
		СтрокаТаблицы = ИтераторТаблицы.ТекущиеДанные;
		СтрокаБазыРаспределения = ИтераторБазы.ТекущиеДанные;
		Для Каждого Ресурс Из ДопРесурсы Цикл
			СуммаРесурса = СтрокаРезультата[Ресурс];
			Если ЕстьДопРесурсыТаблицы Тогда
				СтрокаТаблицы[Ресурс] = СтрокаТаблицы[Ресурс] - СуммаРесурса;
			КонецЕсли;
			Если ЕстьДопРесурсыБазы Тогда
				СуммаБазы = СтрокаБазыРаспределения[ПолеРаспределения];
				Если ТребуетсяПропорция Тогда
					ИтераторБазы.Итоги[Ресурс] = ИтераторБазы.Итоги[Ресурс] - СуммаБазы;
				КонецЕсли;
				СтрокаБазыРаспределения[Ресурс] = СтрокаБазыРаспределения[Ресурс] - Мин(СуммаРесурса, СуммаБазы);
			КонецЕсли;
		КонецЦикла;
		СуммаРаспределения = СтрокаРезультата[ПолеРаспределения];
		СтрокаТаблицы[ПолеРаспределения] = СтрокаТаблицы[ПолеРаспределения] - СуммаРаспределения;
		СуммаБазы = СтрокаБазыРаспределения[ПолеРаспределения];
		Если ТребуетсяПропорция Тогда
			ИтераторБазы.Итоги[ПолеРаспределения] = ИтераторБазы.Итоги[ПолеРаспределения] - СуммаБазы;
		КонецЕсли;
		СтрокаБазыРаспределения[ПолеРаспределения] = СтрокаБазыРаспределения[ПолеРаспределения] - Мин(СуммаРаспределения, СуммаБазы);
		СтрокаРезультата = Неопределено;
	КонецЕсли;
	ТекущиеДанныеОтношения = Стек[МаксУровень - 1].ТекущиеДанные;
	Пока Истина Цикл
		ТекущийИтератор = Стек[ТекущийУровень];
		Если СледующийЭлемент(ТекущийИтератор) Тогда
			Если ТекущийУровень = МаксУровень Тогда
				ДанныеОтношения = Стек[МаксУровень - 1].ТекущиеДанные;
				СтрокаРезультата = РезультатРаспределения.Добавить();
				ЗаполнитьЗначенияСвойств(СтрокаРезультата, ИтераторТаблицы.ТекущиеДанные);
				ЗаполнитьЗначенияСвойств(СтрокаРезультата, ИтераторБазы.ТекущиеДанные);
				Если ТекущиеДанныеОтношения <> ДанныеОтношения И ТребуетсяПропорция Тогда
					Если ТипЗнч(ИтераторБазы.Строки) = Тип("Массив") Тогда
						ТаблицаИтогов = ИтераторБазы.Таблица.Скопировать(ИтераторБазы.Строки);
					Иначе
						ТаблицаИтогов = ИтераторБазы.Таблица.Скопировать();
					КонецЕсли;
					ТаблицаИтогов.Свернуть(, СтрокаРесурсовБазы);
					ЗаполнитьЗначенияСвойств(ИтераторБазы.Итоги, ТаблицаИтогов[0]);
				КонецЕсли;
				//  Рассчитать результат
				Коэффициент = ИтераторБазы.ТекущиеДанные[ПолеРаспределения];
				Если ВидРаспределения = ВидыРаспределения.ПоПорядку Тогда
					СуммаРаспределения = Мин(ИтераторТаблицы.ТекущиеДанные[ПолеРаспределения], Коэффициент);
					СтрокаРезультата[ПолеРаспределения] = СуммаРаспределения;
				ИначеЕсли ВидРаспределения = ВидыРаспределения.ПоБазе Тогда
					СуммаРаспределения = Мин(Окр(ИтераторТаблицы.ТекущиеДанные[ПолеРаспределения] * Коэффициент / ИтераторБазы.Итоги[ПолеРаспределения], Точность, 1), Коэффициент);
					СтрокаРезультата[ПолеРаспределения] = СуммаРаспределения;
				ИначеЕсли ВидРаспределения = ВидыРаспределения.Полное Тогда
					СуммаРаспределения = Окр(ИтераторТаблицы.ТекущиеДанные[ПолеРаспределения] * Коэффициент / ИтераторБазы.Итоги[ПолеРаспределения], Точность, 1);
					СтрокаРезультата[ПолеРаспределения] = СуммаРаспределения;
				Иначе
					ВызватьИсключение "Неопределен вид распределения!"
				КонецЕсли;
				Если ЗначениеЗаполнено(ДопРесурсы) И СуммаРаспределения > 0 Тогда
					СуммаРесурсов = 0;
					СрезРесурсов = Новый Массив;
					Для Каждого Ресурс Из ДопРесурсы Цикл
						Если ЕстьДопРесурсыТаблицы И ЕстьДопРесурсыБазы Тогда
							СуммаРесурса = Мин(ИтераторТаблицы.ТекущиеДанные[Ресурс], ИтераторБазы.ТекущиеДанные[Ресурс]);
						ИначеЕсли ЕстьДопРесурсыБазы Тогда
							СуммаРесурса = ИтераторБазы.ТекущиеДанные[Ресурс];
						ИначеЕсли ЕстьДопРесурсыТаблицы Тогда
							СуммаРесурса = ИтераторТаблицы.ТекущиеДанные[Ресурс];
						Иначе
							ВызватьИсключение "Неизвестный признак доп ресурсов";
						КонецЕсли;
						СрезРесурсов.Добавить(СуммаРесурса);
						СуммаРесурсов = СуммаРесурсов + СуммаРесурса;
					КонецЦикла;
					СуммаРаспределения = Мин(СуммаРаспределения, СуммаРесурсов);
					Если СуммаРаспределения > 0 Тогда
						СрезРаспределенияРесурсов = РаботаСМассивом.РаспределитьСумму(
							СуммаРаспределения,
							СрезРесурсов,
							Точность
						);
						СтрокаРезультата[ПолеРаспределения] = СуммаРаспределения;
						Для й = 0 По ДопРесурсы.ВГраница() Цикл
							Ресурс = ДопРесурсы[й];
							СуммаРесурса = СрезРаспределенияРесурсов[й];
							СтрокаРезультата[Ресурс] = СуммаРесурса;
						КонецЦикла;
					КонецЕсли;
				КонецЕсли;
				Возврат Истина;
			КонецЕсли;
			Направление = 1;
		Иначе
			Направление = -1;
		КонецЕсли;
		ТекущийУровень = ТекущийУровень + Направление;
		Если ТекущийУровень = -1 Тогда
			Сбросить();
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
КонецФункции

#КонецОбласти

Функция Распределить() Экспорт
	Пока Следующий() Цикл
	КонецЦикла;
	УдалитьВременныеТаблицы();
	Возврат ЭтотОбъект;
КонецФункции

Функция ПустаяТаблица() Экспорт
	Возврат ТаблицаРаспределения.Итог(ПолеРаспределения) = 0;
КонецФункции

Функция ПустаяБаза() Экспорт
	Возврат БазаРаспределения.Итог(ПолеРаспределения) = 0;
КонецФункции

Функция ПустойРезультат() Экспорт
	Возврат РезультатРаспределения.Итог(ПолеРаспределения) = 0;
КонецФункции

Функция ВыгрузитьРезультат() Экспорт
	Возврат РезультатРаспределения.Скопировать();
КонецФункции

Функция ОстатокТаблицы() Экспорт
	Возврат ТаблицаРаспределения;
КонецФункции

Функция ОстатокБазы() Экспорт
	Возврат БазаРаспределения;
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции
	
Функция ДобавитьИсточникМодели(ТипИсточника, ИмяИсточника, Псевдоним = "")
	Перем Источник;
	Источник = СтруктураИсточника(ИмяИсточника, Псевдоним);
	Схема.Вставить(ТипИсточника, Источник);
	Возврат Источник;
КонецФункции

Процедура ДобавитьПоляИсточника(МодельЗапроса, Источник, Секция)
	Перем Измерения;
	Если Источник.Свойство(Секция, Измерения) Тогда
		Если Секция = "Ресурсы" Тогда
			Для Каждого Поле Из Измерения Цикл
				МодельЗапроса
					.Поле(СтрШаблон("ВЫРАЗИТЬ(%1 КАК ЧИСЛО(%2, %3))", Поле.Поле, 15, Точность), ?(ЗначениеЗаполнено(Поле.Псевдоним), Поле.Псевдоним, Поле.Поле))
				;
			КонецЦикла;
			Возврат;
		КонецЕсли;
		Для Каждого Поле Из Измерения Цикл
			МодельЗапроса
				.Поле(Поле.Поле, Поле.Псевдоним)
			;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Процедура ДобавитьЗапросИсточника(МодельЗапроса, ИмяИсточника)
	Источник = Схема[ИмяИсточника];
	Если ТипЗнч(Источник.Источник) = Тип("Строка") Тогда
		МодельЗапроса.ЗапросПакета(ИмяИсточника)
			.Источник(Источник.Источник, Источник.Псевдоним)
		;
	Иначе
		МодельЗапроса.ЗапросПакета().Поместить(Источник.Псевдоним)
			.Источник(Источник.Источник, Источник.Псевдоним)
			.Поле("*")
		;
		МодельЗапроса.ЗапросПакета(ИмяИсточника)
			.Источник(Источник.Псевдоним)
		;
	КонецЕсли;
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "ИзмеренияТаблицы");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "ИзмеренияБазы");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Измерения");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Реквизиты");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Ресурсы");
	Для Каждого Порядок Из Источник.Порядок Цикл
		МодельЗапроса
			.Порядок(Порядок.Выражение, Порядок.Направление)
		;
	КонецЦикла;
	Для Каждого ВыражениеОтбора Из Источник.Отбор Цикл
		МодельЗапроса
			.Отбор(ВыражениеОтбора)
		;
	КонецЦикла;
	Если Источник.Автопорядок Тогда
		МодельЗапроса
			.Автопорядок()
		;
	КонецЕсли;
КонецПроцедуры

Функция Абс(Значение)
	Возврат ?(Значение < 0, -Значение, Значение);
КонецФункции

Функция Знак(Значение)
	Возврат ?(Значение < 0, -1, 1);
КонецФункции

Функция Срез(МассивИсточника, НачальныйИндекс = 0)
	Результат = Новый Массив;
	Для й = НачальныйИндекс По МассивИсточника.ВГраница() Цикл
		Результат.Добавить(МассивИсточника[й]);
	КонецЦикла;
	Возврат Результат;
КонецФункции

Функция СтруктураСтроки(Таблица)
	Результат = Новый Структура;
	Для каждого Колонка Из Таблица.Колонки Цикл
		Результат.Вставить(Колонка.Имя);
	КонецЦикла;
	Возврат Результат;
КонецФункции

Процедура ДобавитьИсточник(МодельЗапроса, Псевдоним)
	Источник = Схема[Псевдоним];
	МодельЗапроса
		.Источник(Источник.Источник)
	;
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "ИзмеренияТаблицы");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "ИзмеренияБазы");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Измерения");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Реквизиты");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Ресурсы");
КонецПроцедуры

Функция СтруктураПоля(Поле, Псевдоним = "")
	_Поле = Новый Структура;
	_Поле.Вставить("Поле", Поле);
	_Поле.Вставить("Псевдоним", Псевдоним);
	Возврат _Поле;
КонецФункции

Функция СтруктураИсточника(ИмяИсточника = "", Псевдоним = "")
	_Источник = Новый Структура;
	_Источник.Вставить("Источник", ИмяИсточника);
	_Источник.Вставить("ЭтоИсточникИзОбъекта", ?(ТипЗнч(ИмяИсточника) = Тип("Строка"), Ложь, Истина));
	_Источник.Вставить("Псевдоним", ?(НЕ ЗначениеЗаполнено(Псевдоним), ОбщийКлиентСервер.ИмяПоУникальномуИдентификатору(), Псевдоним));
	_Источник.Вставить("Порядок", Новый Массив);
	_Источник.Вставить("Отбор", Новый Массив);
	_Источник.Вставить("Автопорядок", Ложь);
	
	_Источник.Вставить("ИзмеренияТаблицы", Новый Массив);
	_Источник.Вставить("ИзмеренияБазы", Новый Массив);
	_Источник.Вставить("Измерения", Новый Массив);
	_Источник.Вставить("Реквизиты", Новый Массив);
	_Источник.Вставить("Ресурсы", Новый Массив);
	Возврат _Источник;
КонецФункции

Процедура УдалитьВременныеТаблицы()
	Перем ОписаниеТаблицы;
	Если НЕ ЗначениеЗаполнено(Схема) Тогда
		Возврат;
	КонецЕсли;
	ТаблицыДляУдаления = Новый Массив;
	Если Схема.Свойство("Таблица", ОписаниеТаблицы) И ОписаниеТаблицы.ЭтоИсточникИзОбъекта Тогда
		ТаблицыДляУдаления.Добавить(ОписаниеТаблицы.Псевдоним);
	КонецЕсли;
	Если Схема.Свойство("База", ОписаниеТаблицы) И ОписаниеТаблицы.ЭтоИсточникИзОбъекта Тогда
		ТаблицыДляУдаления.Добавить(ОписаниеТаблицы.Псевдоним);
	КонецЕсли;
	Если Схема.Свойство("Отношение", ОписаниеТаблицы) И ОписаниеТаблицы.ЭтоИсточникИзОбъекта Тогда
		ТаблицыДляУдаления.Добавить(ОписаниеТаблицы.Псевдоним);
	КонецЕсли;
	Если ЗначениеЗаполнено(ТаблицыДляУдаления) Тогда
		МодельЗапроса = Общий.МодельЗапроса(МенеджерВременныхТаблиц);
		Для каждого ТаблицаДляУдаления Из ТаблицыДляУдаления Цикл
			МодельЗапроса.Уничтожить(ТаблицаДляУдаления)
		КонецЦикла;
		МодельЗапроса.ВыполнитьЗапрос();
	КонецЕсли;
КонецПроцедуры

Процедура Очистить() Экспорт
	УдалитьВременныеТаблицы();
	ТипПоля = "";
	ТипИсточника = "";
	Источник = Неопределено;
	Схема = Новый Структура;
	ТаблицаРаспределения = Неопределено;
	БазаРаспределения = Неопределено;
	ТаблицаОтношения = Неопределено;
	ВыполненоРаспределение = Ложь;
КонецПроцедуры

#КонецОбласти

#Область Инициализация

Очистить();
Точность = 2;
//  ПоПорядку - база упорядочена, отношение упорядочено
//  ПропорциональноБазе - база не упорядочена, отношение упорядочено
//  ПропорциональноОтношению - база не упорядочена, отношение не упорядочено
ВидыРаспределения = Новый Структура("ПоПорядку, ПоБазе, Полное", 1, 2, 3);

#КонецОбласти
