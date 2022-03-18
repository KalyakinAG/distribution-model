Перем Модель Экспорт;
Перем МенеджерВременныхТаблиц Экспорт;

Перем ТаблицаРаспределения Экспорт;
Перем ТаблицаОтношения Экспорт;
Перем БазаРаспределения Экспорт;
Перем РезультатРаспределения Экспорт;

Перем Точность Экспорт;
Перем Источник;
Перем ТипПоля;
Перем ТипИсточника;
Перем ПолеРаспределения;

Функция Точность(Значение) Экспорт
	Точность = Значение;
	Возврат ЭтотОбъект;
КонецФункции

Функция УстановитьМенеджерВременныхТаблиц(НовыйМенеджерВременныхТаблиц) Экспорт
	МенеджерВременныхТаблиц = НовыйМенеджерВременныхТаблиц;
	Возврат ЭтотОбъект;
КонецФункции

Функция ДобавитьИсточникМодели(ТипИсточника, ИмяИсточника, Псевдоним = "")
	Перем Источник;
	Источник = СтруктураИсточника(ИмяИсточника, Псевдоним);
	Модель.Вставить(ТипИсточника, Источник);
	Возврат Источник;
КонецФункции

Функция Таблица(ИмяИсточника, Псевдоним = "Таблица") Экспорт
	ТипИсточника = "Таблица";
	Источник = ДобавитьИсточникМодели(ТипИсточника, ИмяИсточника, Псевдоним);
	Возврат ЭтотОбъект;
КонецФункции

Функция Отношение(ИмяИсточника, Псевдоним = "Отношение") Экспорт
	ТипИсточника = "Отношение";
	Источник = ДобавитьИсточникМодели(ТипИсточника, ИмяИсточника, Псевдоним);
	Возврат ЭтотОбъект;
КонецФункции

Функция База(ИмяИсточника, Псевдоним = "База") Экспорт
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
			Если Модель.Таблица.Свойство(ТипПоля, Поля) Тогда
				Для Каждого _Поле Из Поля Цикл
					Поле(_Поле.Псевдоним);
				КонецЦикла;
			КонецЕсли;
			Возврат ЭтотОбъект;
		КонецЕсли;
		//  Измерения Базы из Отношения
		Если Модель.Свойство("Отношение") Тогда
			Если Модель.Отношение.Свойство(ТипПоля, Поля) Тогда
				Для Каждого _Поле Из Поля Цикл
					Поле(_Поле.Псевдоним);
				КонецЦикла;
			КонецЕсли;
			Возврат ЭтотОбъект;
		КонецЕсли;
		//  Измерения Базы из Таблицы		
		Если Модель.Таблица.Свойство(ТипПоля, Поля) Тогда
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

Процедура ДобавитьПоляИсточника(МодельЗапроса, Источник, Секция)
	Перем Измерения;
	Если Источник.Свойство(Секция, Измерения) Тогда
		Для Каждого Поле Из Измерения Цикл
			МодельЗапроса
				.Поле(Поле.Поле, Поле.Псевдоним)
			;
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Процедура ДобавитьЗапросИсточника(МодельЗапроса, Псевдоним)
	Источник = Модель[Псевдоним];
	Если ТипЗнч(Источник.Источник) = Тип("Строка") Тогда
		МодельЗапроса.ЗапросПакета(Псевдоним)
			.Источник(Источник.Источник, Источник.Псевдоним)
		;
	Иначе
		МодельЗапроса.ЗапросПакета().Поместить(Псевдоним)
			.Источник(Источник.Источник, Источник.Псевдоним)
			.Поле("*")
		;
		МодельЗапроса.ЗапросПакета(Псевдоним)
			.Источник(Псевдоним, Источник.Псевдоним)
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

Процедура РаспределитьПоПорядкуЧерезОтношение()
	Перем Измерения;
	МодельЗапроса = Общий.МодельЗапроса(МенеджерВременныхТаблиц);
	ДобавитьЗапросИсточника(МодельЗапроса, "Таблица");
	ДобавитьЗапросИсточника(МодельЗапроса, "Отношение");
	ДобавитьЗапросИсточника(МодельЗапроса, "База");
	МодельЗапроса.ВыполнитьЗапрос();
	
	ЕстьДопРесурсыТаблицы = Модель.Таблица.Ресурсы.Количество() > 1;
	ЕстьДопРесурсыБазы = Модель.База.Ресурсы.Количество() > 1;
	
	_ПоляРесурсов = Новый Массив;
	_ПоляРесурсовБазы = Новый Массив;
	
	Для Каждого Поле Из Модель.База.Ресурсы Цикл
		_ПоляРесурсовБазы.Добавить(Поле.Псевдоним);
	КонецЦикла;
	
	Если ЕстьДопРесурсыТаблицы Тогда
		Для Каждого Поле Из Модель.Таблица.Ресурсы Цикл
			_ПоляРесурсов.Добавить(Поле.Псевдоним);
		КонецЦикла;
	Иначе
		_ПоляРесурсов = _ПоляРесурсовБазы;
	КонецЕсли;
	
	МаскаДопРесурсы = Новый Структура;
	ДопРесурсы = Срез(_ПоляРесурсов, 1);
	Для Каждого Ресурс Из ДопРесурсы Цикл
		МаскаДопРесурсы.Вставить(Ресурс, 0);
	КонецЦикла;
	
	ТаблицаРаспределения = МодельЗапроса.ВыгрузитьРезультат("Таблица");
	БазаРаспределения = МодельЗапроса.ВыгрузитьРезультат("База");
	
	//  Структура результата
	РезультатРаспределения = Новый ТаблицаЗначений;
	
	Для Каждого Колонка Из ТаблицаРаспределения.Колонки Цикл
		РезультатРаспределения.Колонки.Добавить(Колонка.Имя, Новый ОписаниеТипов(Колонка.ТипЗначения,, "NULL"));
	КонецЦикла;
	
	Для Каждого Колонка Из БазаРаспределения.Колонки Цикл
		Если РезультатРаспределения.Колонки.Найти(Колонка.Имя) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		РезультатРаспределения.Колонки.Добавить(Колонка.Имя, Новый ОписаниеТипов(Колонка.ТипЗначения,, "NULL"));
	КонецЦикла;
	
	ПолеРаспределения = _ПоляРесурсов[0];
	
	//{  Отношение
	ТаблицаОтношения = МодельЗапроса.ВыгрузитьРезультат("Отношение");
	
	ОтборОтношения = Новый Структура();
	Для Каждого Измерение Из Модель.Отношение.ИзмеренияТаблицы Цикл
		ОтборОтношения.Вставить(Измерение.Псевдоним);
	КонецЦикла;
	
	ОтборБазы = Новый Структура();
	Если Модель.Отношение.Свойство("ИзмеренияБазы", Измерения) Тогда	
		Для Каждого Измерение Из Измерения Цикл
			ОтборБазы.Вставить(Измерение.Псевдоним);
		КонецЦикла;
	КонецЕсли;
	//}  Отношение
	
	Для Каждого СтрокаТаблицы Из ТаблицаРаспределения Цикл
			
		ОстатокРаспределения = СтрокаТаблицы[ПолеРаспределения];
		Если ОстатокРаспределения = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		//{  Отношение
		Если ЗначениеЗаполнено(ОтборОтношения) Тогда
			ЗаполнитьЗначенияСвойств(ОтборОтношения, СтрокаТаблицы);
			ТаблицаОтношенияРаспределения = ТаблицаОтношения.НайтиСтроки(ОтборОтношения);
		Иначе
			ТаблицаОтношенияРаспределения = ТаблицаОтношения;
		КонецЕсли;
		
		Для Каждого СтрокаОтношенияРаспределения Из ТаблицаОтношенияРаспределения Цикл
		//}  Отношение
			
			Если ЗначениеЗаполнено(ОтборБазы) Тогда
				ЗаполнитьЗначенияСвойств(ОтборБазы, СтрокаОтношенияРаспределения);
				ТаблицаБазыРаспределения = БазаРаспределения.НайтиСтроки(ОтборБазы);
			Иначе
				ТаблицаБазыРаспределения = БазаРаспределения;
			КонецЕсли;
			
			Для Каждого СтрокаБазыРаспределения Из ТаблицаБазыРаспределения Цикл
				
				СуммаОстатокБазы = СтрокаБазыРаспределения[ПолеРаспределения];
				Если СуммаОстатокБазы = 0 Тогда
					Продолжить;
				КонецЕсли;
				
				СуммаРаспределения = Мин(ОстатокРаспределения, СуммаОстатокБазы);
				
				СтрокаРезультата = РезультатРаспределения.Добавить();
				ЗаполнитьЗначенияСвойств(СтрокаРезультата, СтрокаТаблицы);
				ЗаполнитьЗначенияСвойств(СтрокаРезультата, СтрокаБазыРаспределения);
				СтрокаРезультата[ПолеРаспределения] = СуммаРаспределения;
				
				Если ЗначениеЗаполнено(ДопРесурсы) Тогда
					СуммаРесурсов = 0;
					СрезРесурсов = Новый Массив;
					Для Каждого Ресурс Из ДопРесурсы Цикл
						
						Если ЕстьДопРесурсыТаблицы И ЕстьДопРесурсыБазы Тогда
							СуммаРесурса = Мин(СтрокаБазыРаспределения[Ресурс], СтрокаТаблицы[Ресурс]);
						ИначеЕсли ЕстьДопРесурсыБазы Тогда
							СуммаРесурса = СтрокаБазыРаспределения[Ресурс];
						Иначе
							СуммаРесурса = СтрокаТаблицы[Ресурс];
						КонецЕсли;
						
						СрезРесурсов.Добавить(СуммаРесурса);
						СуммаРесурсов = СуммаРесурсов + СуммаРесурса;
					КонецЦикла;
					
					СуммаРаспределения = Мин(ОстатокРаспределения, СуммаОстатокБазы, СуммаРесурсов);
					
					СрезРаспределенияРесурсов = ОбщегоНазначенияКлиентСервер.РаспределитьСуммуПропорциональноКоэффициентам(
						СуммаРаспределения,
						СрезРесурсов,
						Точность
					);
					
					СтрокаРезультата[ПолеРаспределения] = СуммаРаспределения;
					Для й = 0 По ДопРесурсы.ВГраница() Цикл
						Ресурс = ДопРесурсы[й];
						СуммаРесурса = СрезРаспределенияРесурсов[й];
						СтрокаРезультата[Ресурс] = СуммаРесурса;
						Если ЕстьДопРесурсыТаблицы Тогда
							СтрокаТаблицы[Ресурс] = СтрокаТаблицы[Ресурс] - СуммаРесурса;
						КонецЕсли;
						Если ЕстьДопРесурсыБазы Тогда
							СтрокаБазыРаспределения[Ресурс] = СтрокаБазыРаспределения[Ресурс] - СуммаРесурса;
						КонецЕсли;
					КонецЦикла;
					
				КонецЕсли;
				
				СтрокаБазыРаспределения[ПолеРаспределения] = СтрокаБазыРаспределения[ПолеРаспределения] - СуммаРаспределения;
				СтрокаТаблицы[ПолеРаспределения] = СтрокаТаблицы[ПолеРаспределения] - СуммаРаспределения;
				
				ОстатокРаспределения = ОстатокРаспределения - СуммаРаспределения;
				
				Если ОстатокРаспределения = 0 Тогда
					Прервать;
				КонецЕсли;
				
			КонецЦикла;//  База
		КонецЦикла;//  Отношение
	КонецЦикла;//  Таблица
	
КонецПроцедуры

Процедура ДобавитьИсточник(МодельЗапроса, Псевдоним)
	Источник = Модель[Псевдоним];
	МодельЗапроса
		.Источник(Источник.Источник)
	;
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "ИзмеренияТаблицы");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "ИзмеренияБазы");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Измерения");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Реквизиты");
	ДобавитьПоляИсточника(МодельЗапроса, Источник, "Ресурсы");
КонецПроцедуры

Процедура РаспределитьПоПорядкуЧерезВыборку()
	Перем Измерения;
	МодельЗапроса = Общий.МодельЗапроса(МенеджерВременныхТаблиц);
	
	МодельЗапроса.ЗапросПакета()
		.Источник(Модель.Таблица)
	;
	ДобавитьИсточник(МодельЗапроса, "Таблица");
	ДобавитьИсточник(МодельЗапроса, "База");
	
	Если Модель.Таблица.Свойства("Измерения") Тогда
		МодельЗапроса.ЛевоеСоединение(Модель.Таблица.Источник.Псевдоним, Модель.База.Источник.Псевдоним);
		Для Каждого Поле Из Модель.Таблица.Измерения Цикл
			МодельЗапроса.Связь(Поле.Псевдоним)				
		КонецЦикла; 
	КонецЕсли;
	
	Для Каждого Порядок Из Модель.Таблица.Порядок Цикл
		МодельЗапроса
			.Порядок(Порядок.Выражение, Порядок.Направление)
		;
	КонецЦикла;
	
	Для Каждого Порядок Из Модель.База.Порядок Цикл
		МодельЗапроса
			.Порядок(Порядок.Выражение, Порядок.Направление)
		;
	КонецЦикла;

	Для Каждого ВыражениеОтбора Из Модель.Таблица.Отбор Цикл
		МодельЗапроса
			.Отбор(ВыражениеОтбора)
		;
	КонецЦикла;

	Для Каждого ВыражениеОтбора Из Модель.База.Отбор Цикл
		МодельЗапроса
			.Отбор(ВыражениеОтбора)
		;
	КонецЦикла;
	
	Если Модель.Таблица.Автопорядок ИЛИ Модель.База.Автопорядок Тогда
		МодельЗапроса
			.Автопорядок()
		;
	КонецЕсли;
	
	МодельЗапроса.ВыполнитьЗапрос();
	
	ЕстьДопРесурсыТаблицы = Модель.Таблица.Ресурсы.Количество() > 1;
	ЕстьДопРесурсыБазы = Модель.База.Ресурсы.Количество() > 1;
	
	_ПоляРесурсов = Новый Массив;
	_ПоляРесурсовБазы = Новый Массив;
	
	Для Каждого Поле Из Модель.База.Ресурсы Цикл
		_ПоляРесурсовБазы.Добавить(Поле.Псевдоним);
	КонецЦикла;
	
	Если ЕстьДопРесурсыТаблицы Тогда
		Для Каждого Поле Из Модель.Таблица.Ресурсы Цикл
			_ПоляРесурсов.Добавить(Поле.Псевдоним);
		КонецЦикла;
	Иначе
		_ПоляРесурсов = _ПоляРесурсовБазы;
	КонецЕсли;
	
	МаскаДопРесурсы = Новый Структура;
	ДопРесурсы = Срез(_ПоляРесурсов, 1);
	Для Каждого Ресурс Из ДопРесурсы Цикл
		МаскаДопРесурсы.Вставить(Ресурс, 0);
	КонецЦикла;
	
	ТаблицаРаспределения = МодельЗапроса.ВыгрузитьРезультат("Таблица");
	БазаРаспределения = МодельЗапроса.ВыгрузитьРезультат("База");
	
	//  Структура результата
	РезультатРаспределения = Новый ТаблицаЗначений;
	
	Для Каждого Колонка Из ТаблицаРаспределения.Колонки Цикл
		РезультатРаспределения.Колонки.Добавить(Колонка.Имя, Новый ОписаниеТипов(Колонка.ТипЗначения,, "NULL"));
	КонецЦикла;
	
	Для Каждого Колонка Из БазаРаспределения.Колонки Цикл
		Если РезультатРаспределения.Колонки.Найти(Колонка.Имя) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		РезультатРаспределения.Колонки.Добавить(Колонка.Имя, Новый ОписаниеТипов(Колонка.ТипЗначения,, "NULL"));
	КонецЦикла;
	
	ПолеРаспределения = _ПоляРесурсов[0];
	
	ЕстьДопРесурсыТаблицы = Модель.Таблица.Ресурсы.Количество() > 1;
	ЕстьДопРесурсыБазы = Модель.База.Ресурсы.Количество() > 1;
	
	ОтборБазы = Новый Структура();
	Если Модель.База.Свойство("Измерения", Измерения) Тогда	
		Для Каждого Измерение Из Измерения Цикл
			ОтборБазы.Вставить(Измерение.Псевдоним);
		КонецЦикла;
	КонецЕсли;
	
	Для Каждого СтрокаТаблицы Из ТаблицаРаспределения Цикл
		
		ОстатокРаспределения = СтрокаТаблицы[ПолеРаспределения];
		Если ОстатокРаспределения = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ОтборБазы) Тогда
			ЗаполнитьЗначенияСвойств(ОтборБазы, СтрокаТаблицы);
			ТаблицаБазыРаспределения = БазаРаспределения.НайтиСтроки(ОтборБазы);
		Иначе
			ТаблицаБазыРаспределения = БазаРаспределения;
		КонецЕсли;
		
		Для Каждого СтрокаБазыРаспределения Из ТаблицаБазыРаспределения Цикл
			
			СуммаОстатокБазы = СтрокаБазыРаспределения[ПолеРаспределения];
			Если СуммаОстатокБазы = 0 Тогда
				Продолжить;
			КонецЕсли;
			
			СуммаРаспределения = Мин(ОстатокРаспределения, СуммаОстатокБазы);
			
			СтрокаРезультата = РезультатРаспределения.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаРезультата, СтрокаТаблицы);
			ЗаполнитьЗначенияСвойств(СтрокаРезультата, СтрокаБазыРаспределения);
			СтрокаРезультата[ПолеРаспределения] = СуммаРаспределения;
			
			Если ЗначениеЗаполнено(ДопРесурсы) Тогда
				СуммаРесурсов = 0;
				СрезРесурсов = Новый Массив;
				Для Каждого Ресурс Из ДопРесурсы Цикл
					
					Если ЕстьДопРесурсыТаблицы И ЕстьДопРесурсыБазы Тогда
						СуммаРесурса = Мин(СтрокаБазыРаспределения[Ресурс], СтрокаТаблицы[Ресурс]);
					ИначеЕсли ЕстьДопРесурсыБазы Тогда
						СуммаРесурса = СтрокаБазыРаспределения[Ресурс];
					Иначе
						СуммаРесурса = СтрокаТаблицы[Ресурс];
					КонецЕсли;
					
					СрезРесурсов.Добавить(СуммаРесурса);
					СуммаРесурсов = СуммаРесурсов + СуммаРесурса;
				КонецЦикла;
				
				СуммаРаспределения = Мин(ОстатокРаспределения, СуммаОстатокБазы, СуммаРесурсов);
				
				СрезРаспределенияРесурсов = ОбщегоНазначенияКлиентСервер.РаспределитьСуммуПропорциональноКоэффициентам(
					СуммаРаспределения,
					СрезРесурсов,
					Точность
				);
				
				СтрокаРезультата[ПолеРаспределения] = СуммаРаспределения;
				Для й = 0 По ДопРесурсы.ВГраница() Цикл
					Ресурс = ДопРесурсы[й];
					СуммаРесурса = СрезРаспределенияРесурсов[й];
					СтрокаРезультата[Ресурс] = СуммаРесурса;
					Если ЕстьДопРесурсыТаблицы Тогда
						СтрокаТаблицы[Ресурс] = СтрокаТаблицы[Ресурс] - СуммаРесурса;
					КонецЕсли;
					Если ЕстьДопРесурсыБазы Тогда
						СтрокаБазыРаспределения[Ресурс] = СтрокаБазыРаспределения[Ресурс] - СуммаРесурса;
					КонецЕсли;
				КонецЦикла;
				
			КонецЕсли;
			
			СтрокаБазыРаспределения[ПолеРаспределения] = СтрокаБазыРаспределения[ПолеРаспределения] - СуммаРаспределения;
			СтрокаТаблицы[ПолеРаспределения] = СтрокаТаблицы[ПолеРаспределения] - СуммаРаспределения;
			
			ОстатокРаспределения = ОстатокРаспределения - СуммаРаспределения;
			
			Если ОстатокРаспределения = 0 Тогда
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

Процедура РаспределитьПоПорядку()
	Перем Измерения;
	МодельЗапроса = Общий.МодельЗапроса(МенеджерВременныхТаблиц);
	ДобавитьЗапросИсточника(МодельЗапроса, "Таблица");
	ДобавитьЗапросИсточника(МодельЗапроса, "База");
	МодельЗапроса.ВыполнитьЗапрос();
	
	ЕстьДопРесурсыТаблицы = Модель.Таблица.Ресурсы.Количество() > 1;
	ЕстьДопРесурсыБазы = Модель.База.Ресурсы.Количество() > 1;
	
	_ПоляРесурсов = Новый Массив;
	_ПоляРесурсовБазы = Новый Массив;
	
	Для Каждого Поле Из Модель.База.Ресурсы Цикл
		_ПоляРесурсовБазы.Добавить(Поле.Псевдоним);
	КонецЦикла;
	
	Если ЕстьДопРесурсыТаблицы Тогда
		Для Каждого Поле Из Модель.Таблица.Ресурсы Цикл
			_ПоляРесурсов.Добавить(Поле.Псевдоним);
		КонецЦикла;
	Иначе
		_ПоляРесурсов = _ПоляРесурсовБазы;
	КонецЕсли;
	
	МаскаДопРесурсы = Новый Структура;
	ДопРесурсы = Срез(_ПоляРесурсов, 1);
	Для Каждого Ресурс Из ДопРесурсы Цикл
		МаскаДопРесурсы.Вставить(Ресурс, 0);
	КонецЦикла;
	
	ТаблицаРаспределения = МодельЗапроса.ВыгрузитьРезультат("Таблица");
	БазаРаспределения = МодельЗапроса.ВыгрузитьРезультат("База");
	
	//  Структура результата
	РезультатРаспределения = Новый ТаблицаЗначений;
	
	Для Каждого Колонка Из ТаблицаРаспределения.Колонки Цикл
		РезультатРаспределения.Колонки.Добавить(Колонка.Имя, Новый ОписаниеТипов(Колонка.ТипЗначения,, "NULL"));
	КонецЦикла;
	
	Для Каждого Колонка Из БазаРаспределения.Колонки Цикл
		Если РезультатРаспределения.Колонки.Найти(Колонка.Имя) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		РезультатРаспределения.Колонки.Добавить(Колонка.Имя, Новый ОписаниеТипов(Колонка.ТипЗначения,, "NULL"));
	КонецЦикла;
	
	ПолеРаспределения = _ПоляРесурсов[0];
	
	ЕстьДопРесурсыТаблицы = Модель.Таблица.Ресурсы.Количество() > 1;
	ЕстьДопРесурсыБазы = Модель.База.Ресурсы.Количество() > 1;
	
	ОтборБазы = Новый Структура();
	Если Модель.База.Свойство("Измерения", Измерения) Тогда	
		Для Каждого Измерение Из Измерения Цикл
			ОтборБазы.Вставить(Измерение.Псевдоним);
		КонецЦикла;
	КонецЕсли;
	
	Для Каждого СтрокаТаблицы Из ТаблицаРаспределения Цикл
		
		ОстатокРаспределения = СтрокаТаблицы[ПолеРаспределения];
		Если ОстатокРаспределения = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ОтборБазы) Тогда
			ЗаполнитьЗначенияСвойств(ОтборБазы, СтрокаТаблицы);
			ТаблицаБазыРаспределения = БазаРаспределения.НайтиСтроки(ОтборБазы);
		Иначе
			ТаблицаБазыРаспределения = БазаРаспределения;
		КонецЕсли;
		
		Для Каждого СтрокаБазыРаспределения Из ТаблицаБазыРаспределения Цикл
			
			СуммаОстатокБазы = СтрокаБазыРаспределения[ПолеРаспределения];
			Если СуммаОстатокБазы = 0 Тогда
				Продолжить;
			КонецЕсли;
			
			СуммаРаспределения = Мин(ОстатокРаспределения, СуммаОстатокБазы);
			
			СтрокаРезультата = РезультатРаспределения.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаРезультата, СтрокаТаблицы);
			ЗаполнитьЗначенияСвойств(СтрокаРезультата, СтрокаБазыРаспределения);
			СтрокаРезультата[ПолеРаспределения] = СуммаРаспределения;
			
			Если ЗначениеЗаполнено(ДопРесурсы) Тогда
				СуммаРесурсов = 0;
				СрезРесурсов = Новый Массив;
				Для Каждого Ресурс Из ДопРесурсы Цикл
					
					Если ЕстьДопРесурсыТаблицы И ЕстьДопРесурсыБазы Тогда
						СуммаРесурса = Мин(СтрокаБазыРаспределения[Ресурс], СтрокаТаблицы[Ресурс]);
					ИначеЕсли ЕстьДопРесурсыБазы Тогда
						СуммаРесурса = СтрокаБазыРаспределения[Ресурс];
					Иначе
						СуммаРесурса = СтрокаТаблицы[Ресурс];
					КонецЕсли;
					
					СрезРесурсов.Добавить(СуммаРесурса);
					СуммаРесурсов = СуммаРесурсов + СуммаРесурса;
				КонецЦикла;
				
				СуммаРаспределения = Мин(ОстатокРаспределения, СуммаОстатокБазы, СуммаРесурсов);
				
				СрезРаспределенияРесурсов = ОбщегоНазначенияКлиентСервер.РаспределитьСуммуПропорциональноКоэффициентам(
					СуммаРаспределения,
					СрезРесурсов,
					Точность
				);
				
				СтрокаРезультата[ПолеРаспределения] = СуммаРаспределения;
				Для й = 0 По ДопРесурсы.ВГраница() Цикл
					Ресурс = ДопРесурсы[й];
					СуммаРесурса = СрезРаспределенияРесурсов[й];
					СтрокаРезультата[Ресурс] = СуммаРесурса;
					Если ЕстьДопРесурсыТаблицы Тогда
						СтрокаТаблицы[Ресурс] = СтрокаТаблицы[Ресурс] - СуммаРесурса;
					КонецЕсли;
					Если ЕстьДопРесурсыБазы Тогда
						СтрокаБазыРаспределения[Ресурс] = СтрокаБазыРаспределения[Ресурс] - СуммаРесурса;
					КонецЕсли;
				КонецЦикла;
				
			КонецЕсли;
			
			СтрокаБазыРаспределения[ПолеРаспределения] = СтрокаБазыРаспределения[ПолеРаспределения] - СуммаРаспределения;
			СтрокаТаблицы[ПолеРаспределения] = СтрокаТаблицы[ПолеРаспределения] - СуммаРаспределения;
			
			ОстатокРаспределения = ОстатокРаспределения - СуммаРаспределения;
			
			Если ОстатокРаспределения = 0 Тогда
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

Процедура РаспределитьПропорциональноЧерезОтношение()
	Перем Измерения;
	МодельЗапроса = Общий.МодельЗапроса(МенеджерВременныхТаблиц);
	ДобавитьЗапросИсточника(МодельЗапроса, "Таблица");
	ДобавитьЗапросИсточника(МодельЗапроса, "Отношение");
	ДобавитьЗапросИсточника(МодельЗапроса, "База");
	МодельЗапроса.ВыполнитьЗапрос();
	
	ЕстьДопРесурсыТаблицы = Модель.Таблица.Ресурсы.Количество() > 1;
	ЕстьДопРесурсыБазы = Модель.База.Ресурсы.Количество() > 1;
	Если ЕстьДопРесурсыТаблицы И ЕстьДопРесурсыБазы Тогда
		ВызватьИсключение "Нельзя для пропорционального распределения использовать одновременно доп ресурсы для таблицы и базы!";
	КонецЕсли;
	
	_ПоляРезультата = Новый Массив;
	_ПоляБазы = Новый Массив;
	_ПоляРесурсов = Новый Массив;
	_ПоляРесурсовБазы = Новый Массив;
	
	Для Каждого Поле Из Модель.База.Ресурсы Цикл
		_ПоляРесурсовБазы.Добавить(Поле.Псевдоним);
	КонецЦикла;
	
	Если ЕстьДопРесурсыТаблицы Тогда
		Для Каждого Поле Из Модель.Таблица.Ресурсы Цикл
			_ПоляРесурсов.Добавить(Поле.Псевдоним);
		КонецЦикла;
	Иначе
		_ПоляРесурсов = _ПоляРесурсовБазы;
	КонецЕсли;
	
	МаскаДопРесурсы = Новый Структура;
	ДопРесурсы = Срез(_ПоляРесурсов, 1);
	Для Каждого Ресурс Из ДопРесурсы Цикл
		МаскаДопРесурсы.Вставить(Ресурс, 0);
	КонецЦикла;
	ПоляРесурсов = СтрСоединить(_ПоляРесурсов, ",");
	ПоляРесурсовБазы = СтрСоединить(_ПоляРесурсовБазы, ",");
	
	ТаблицаРаспределения = МодельЗапроса.ВыгрузитьРезультат("Таблица");
	БазаРаспределения = МодельЗапроса.ВыгрузитьРезультат("База");
	
	//  Результат распределения: колонки таблицы
	РезультатРаспределения = Новый ТаблицаЗначений;
	Для Каждого Колонка Из ТаблицаРаспределения.Колонки Цикл
		ЭтоРесурс = _ПоляРесурсов.Найти(Колонка.Имя) <> Неопределено;
		Если НЕ ЭтоРесурс Тогда
			_ПоляРезультата.Добавить(Колонка.Имя);
		КонецЕсли;
		РезультатРаспределения.Колонки.Добавить(Колонка.Имя, Новый ОписаниеТипов(Колонка.ТипЗначения,, "NULL"));
	КонецЦикла;
	
	//  Результат распределения: колонки базы
	Для Каждого Колонка Из БазаРаспределения.Колонки Цикл
		ЭтоРесурс = _ПоляРесурсов.Найти(Колонка.Имя) <> Неопределено;
		Если НЕ ЭтоРесурс Тогда
			_ПоляБазы.Добавить(Колонка.Имя);
		КонецЕсли;
		Если РезультатРаспределения.Колонки.Найти(Колонка.Имя) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		Если НЕ ЭтоРесурс Тогда
			_ПоляРезультата.Добавить(Колонка.Имя);
		КонецЕсли;
		РезультатРаспределения.Колонки.Добавить(Колонка.Имя, Новый ОписаниеТипов(Колонка.ТипЗначения,, "NULL"));
	КонецЦикла;
	
	ПоляРезультата = СтрСоединить(_ПоляРезультата, ",");
	ПоляБазы = СтрСоединить(_ПоляБазы, ",");
	
	ПолеРаспределения = _ПоляРесурсов[0];
	
	//{  Отношение
	ТаблицаОтношения = МодельЗапроса.ВыгрузитьРезультат("Отношение");
	
	ОтборОтношения = Новый Структура();
	Для Каждого Измерение Из Модель.Отношение.ИзмеренияТаблицы Цикл
		ОтборОтношения.Вставить(Измерение.Псевдоним);
	КонецЦикла;
	
	ОтборБазы = Новый Структура();
	Если Модель.Отношение.Свойство("ИзмеренияБазы", Измерения) Тогда
		Для Каждого Измерение Из Измерения Цикл
			ОтборБазы.Вставить(Измерение.Псевдоним);
		КонецЦикла;
	КонецЕсли;
	//}  Отношение
	
	Для Каждого СтрокаТаблицы Из ТаблицаРаспределения Цикл
		ОстатокРаспределения = СтрокаТаблицы[ПолеРаспределения];
		Если ОстатокРаспределения = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		//{  Отношение
		Если ЗначениеЗаполнено(ОтборОтношения) Тогда
			ЗаполнитьЗначенияСвойств(ОтборОтношения, СтрокаТаблицы);
			ТаблицаОтношенияРаспределения = ТаблицаОтношения.НайтиСтроки(ОтборОтношения);
		Иначе
			ТаблицаОтношенияРаспределения = ТаблицаОтношения;
		КонецЕсли;
		
		Для Каждого СтрокаОтношенияРаспределения Из ТаблицаОтношенияРаспределения Цикл
		//}  Отношение
		
			Если ЗначениеЗаполнено(ОтборБазы) Тогда
				ЗаполнитьЗначенияСвойств(ОтборБазы, СтрокаОтношенияРаспределения);
				ТаблицаБазыРаспределения = БазаРаспределения.Скопировать(ОтборБазы);
			Иначе
				ТаблицаБазыРаспределения = БазаРаспределения.Скопировать();
			КонецЕсли;
			
			СуммаРаспределения = Мин(ОстатокРаспределения, ТаблицаБазыРаспределения.Итог(ПолеРаспределения));
			
			Если СуммаРаспределения = 0 Тогда
				Продолжить;
			КонецЕсли; 
			
			ТаблицаБазыРаспределения.ЗагрузитьКолонку(
				ОбщегоНазначенияКлиентСервер.РаспределитьСуммуПропорциональноКоэффициентам(
					СуммаРаспределения,
					ТаблицаБазыРаспределения.ВыгрузитьКолонку(ПолеРаспределения),
					Точность
				), 
				ПолеРаспределения
			);
		
			Для Каждого СтрокаБазыРаспределения Из ТаблицаБазыРаспределения Цикл
				СуммаБазыРаспределения = СтрокаБазыРаспределения[ПолеРаспределения];
				Если СуммаБазыРаспределения = 0 Тогда
					Если ЕстьДопРесурсыБазы Тогда
						ЗаполнитьЗначенияСвойств(СтрокаБазыРаспределения, МаскаДопРесурсы);
					КонецЕсли;
					Продолжить;
				КонецЕсли;
				
				СтрокаБазы = БазаРаспределения.Добавить();
				ЗаполнитьЗначенияСвойств(СтрокаБазы, СтрокаБазыРаспределения);
				
				СтрокаРезультата = РезультатРаспределения.Добавить();
				ЗаполнитьЗначенияСвойств(СтрокаРезультата, СтрокаТаблицы);
				ЗаполнитьЗначенияСвойств(СтрокаРезультата, СтрокаБазыРаспределения);
				
				Если ЗначениеЗаполнено(ДопРесурсы) Тогда
					СрезДопРесурсов = Новый Массив;
					Для Каждого Ресурс Из ДопРесурсы Цикл
						СрезДопРесурсов.Добавить(?(ЕстьДопРесурсыБазы, СтрокаБазыРаспределения[Ресурс], СтрокаТаблицы[Ресурс]));
					КонецЦикла;
					
					СрезБазыРаспределения = ОбщегоНазначенияКлиентСервер.РаспределитьСуммуПропорциональноКоэффициентам(
						СуммаБазыРаспределения,
						СрезДопРесурсов,
						Точность
					);
					//  Перенос результата распределения по доп ресурсам
					Для й = 0 По ДопРесурсы.ВГраница() Цикл
						Ресурс = ДопРесурсы[й];
						СуммаРесурса = СрезБазыРаспределения[й];
						Если ЕстьДопРесурсыБазы Тогда
							СтрокаБазы[Ресурс] = -СуммаРесурса;//  уменьшение базы
						Иначе
							СтрокаТаблицы[Ресурс] = СтрокаТаблицы[Ресурс] - СуммаРесурса;//  уменьшение таблицы
						КонецЕсли;
						СтрокаРезультата[Ресурс] = СуммаРесурса;
					КонецЦикла;
				КонецЕсли;
				
				СтрокаБазы[ПолеРаспределения] = -СуммаБазыРаспределения;
				СтрокаТаблицы[ПолеРаспределения] = СтрокаТаблицы[ПолеРаспределения] - СуммаБазыРаспределения;
				
			КонецЦикла;//  База
			
			БазаРаспределения.Свернуть(ПоляБазы, ПоляРесурсовБазы);
		КонецЦикла;//  Отношение
	КонецЦикла;//  Таблица
	
	РезультатРаспределения.Свернуть(ПоляРезультата, ПоляРесурсов);
	
КонецПроцедуры

Процедура РаспределитьПропорционально()
	МодельЗапроса = Общий.МодельЗапроса(МенеджерВременныхТаблиц);
	ДобавитьЗапросИсточника(МодельЗапроса, "Таблица");
	ДобавитьЗапросИсточника(МодельЗапроса, "База");
	МодельЗапроса.ВыполнитьЗапрос();
	
	ЕстьДопРесурсыТаблицы = Модель.Таблица.Ресурсы.Количество() > 1;
	ЕстьДопРесурсыБазы = Модель.База.Ресурсы.Количество() > 1;
	Если ЕстьДопРесурсыТаблицы И ЕстьДопРесурсыБазы Тогда
		ВызватьИсключение "Нельзя для пропорционального распределения использовать одновременно доп ресурсы для таблицы и базы!";
	КонецЕсли;
	
	_ПоляРезультата = Новый Массив;
	_ПоляБазы = Новый Массив;
	_ПоляРесурсов = Новый Массив;
	_ПоляРесурсовБазы = Новый Массив;
	
	Для Каждого Поле Из Модель.База.Ресурсы Цикл
		_ПоляРесурсовБазы.Добавить(Поле.Псевдоним);
	КонецЦикла;
	
	Если ЕстьДопРесурсыТаблицы Тогда
		Для Каждого Поле Из Модель.Таблица.Ресурсы Цикл
			_ПоляРесурсов.Добавить(Поле.Псевдоним);
		КонецЦикла;
	Иначе
		_ПоляРесурсов = _ПоляРесурсовБазы;
	КонецЕсли;
	
	МаскаДопРесурсы = Новый Структура;
	ДопРесурсы = Срез(_ПоляРесурсов, 1);
	Для Каждого Ресурс Из ДопРесурсы Цикл
		МаскаДопРесурсы.Вставить(Ресурс, 0);
	КонецЦикла;
	ПоляРесурсов = СтрСоединить(_ПоляРесурсов, ",");
	ПоляРесурсовБазы = СтрСоединить(_ПоляРесурсовБазы, ",");
	
	ТаблицаРаспределения = МодельЗапроса.ВыгрузитьРезультат("Таблица");
	БазаРаспределения = МодельЗапроса.ВыгрузитьРезультат("База");
	
	//  Результат распределения: колонки таблицы
	РезультатРаспределения = Новый ТаблицаЗначений;
	Для Каждого Колонка Из ТаблицаРаспределения.Колонки Цикл
		ЭтоРесурс = _ПоляРесурсов.Найти(Колонка.Имя) <> Неопределено;
		Если НЕ ЭтоРесурс Тогда
			_ПоляРезультата.Добавить(Колонка.Имя);
		КонецЕсли;
		РезультатРаспределения.Колонки.Добавить(Колонка.Имя, Новый ОписаниеТипов(Колонка.ТипЗначения,, "NULL"));
	КонецЦикла;
	
	//  Результат распределения: колонки базы
	Для Каждого Колонка Из БазаРаспределения.Колонки Цикл
		ЭтоРесурс = _ПоляРесурсов.Найти(Колонка.Имя) <> Неопределено;
		Если НЕ ЭтоРесурс Тогда
			_ПоляБазы.Добавить(Колонка.Имя);
		КонецЕсли;
		Если РезультатРаспределения.Колонки.Найти(Колонка.Имя) <> Неопределено Тогда
			Продолжить;
		КонецЕсли;
		Если НЕ ЭтоРесурс Тогда
			_ПоляРезультата.Добавить(Колонка.Имя);
		КонецЕсли;
		РезультатРаспределения.Колонки.Добавить(Колонка.Имя, Новый ОписаниеТипов(Колонка.ТипЗначения,, "NULL"));
	КонецЦикла;
	
	ПоляРезультата = СтрСоединить(_ПоляРезультата, ",");
	ПоляБазы = СтрСоединить(_ПоляБазы, ",");
	
	ПолеРаспределения = _ПоляРесурсов[0];
	
	ОтборБазы = Новый Структура;
	Если Модель.База.Свойство("Измерения") Тогда
		Для Каждого Измерение Из Модель.База.Измерения Цикл
			ОтборБазы.Вставить(Измерение.Псевдоним);
		КонецЦикла;
	КонецЕсли;
	
	Для Каждого СтрокаТаблицы Из ТаблицаРаспределения Цикл
		ОстатокРаспределения = СтрокаТаблицы[ПолеРаспределения];
		Если ОстатокРаспределения = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(ОтборБазы, СтрокаТаблицы);
		
		Если ЗначениеЗаполнено(ОтборБазы) Тогда
			ТаблицаБазыРаспределения = БазаРаспределения.Скопировать(ОтборБазы);
		Иначе
			ТаблицаБазыРаспределения = БазаРаспределения.Скопировать();
		КонецЕсли;
		
		СуммаРаспределения = Мин(ОстатокРаспределения, ТаблицаБазыРаспределения.Итог(ПолеРаспределения));
		
		Если СуммаРаспределения = 0 Тогда
			Продолжить;
		КонецЕсли; 
		
		ТаблицаБазыРаспределения.ЗагрузитьКолонку(
			ОбщегоНазначенияКлиентСервер.РаспределитьСуммуПропорциональноКоэффициентам(
				СуммаРаспределения,
				ТаблицаБазыРаспределения.ВыгрузитьКолонку(ПолеРаспределения),
				Точность
			), 
			ПолеРаспределения
		);
		
		Для Каждого СтрокаБазыРаспределения Из ТаблицаБазыРаспределения Цикл
			СуммаБазыРаспределения = СтрокаБазыРаспределения[ПолеРаспределения];
			Если СуммаБазыРаспределения = 0 Тогда
				Если ЕстьДопРесурсыБазы Тогда
					ЗаполнитьЗначенияСвойств(СтрокаБазыРаспределения, МаскаДопРесурсы);
				КонецЕсли;
				Продолжить;
			КонецЕсли;
			
			СтрокаБазы = БазаРаспределения.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаБазы, СтрокаБазыРаспределения);
			
			СтрокаРезультата = РезультатРаспределения.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаРезультата, СтрокаТаблицы);
			ЗаполнитьЗначенияСвойств(СтрокаРезультата, СтрокаБазыРаспределения);
			
			Если ЗначениеЗаполнено(ДопРесурсы) Тогда
				СрезДопРесурсов = Новый Массив;
				Для Каждого Ресурс Из ДопРесурсы Цикл
					СрезДопРесурсов.Добавить(?(ЕстьДопРесурсыБазы, СтрокаБазыРаспределения[Ресурс], СтрокаТаблицы[Ресурс]));
				КонецЦикла;
				
				СрезБазыРаспределения = ОбщегоНазначенияКлиентСервер.РаспределитьСуммуПропорциональноКоэффициентам(
					СуммаБазыРаспределения,
					СрезДопРесурсов,
					Точность
				);
				//  Перенос результата распределения по доп ресурсам
				Для й = 0 По ДопРесурсы.ВГраница() Цикл
					Ресурс = ДопРесурсы[й];
					СуммаРесурса = СрезБазыРаспределения[й];
					Если ЕстьДопРесурсыБазы Тогда
						СтрокаБазы[Ресурс] = -СуммаРесурса;//  уменьшение базы
					Иначе
						СтрокаТаблицы[Ресурс] = СтрокаТаблицы[Ресурс] - СуммаРесурса;//  уменьшение таблицы
					КонецЕсли;
					СтрокаРезультата[Ресурс] = СуммаРесурса;
				КонецЦикла;
			КонецЕсли;
			
			СтрокаБазы[ПолеРаспределения] = -СуммаБазыРаспределения;
			СтрокаТаблицы[ПолеРаспределения] = СтрокаТаблицы[ПолеРаспределения] - СуммаБазыРаспределения;
			
		КонецЦикла;
		
		БазаРаспределения.Свернуть(ПоляБазы, ПоляРесурсовБазы);
		
	КонецЦикла;
	
	РезультатРаспределения.Свернуть(ПоляРезультата, ПоляРесурсов);
	
КонецПроцедуры

Функция Распределить() Экспорт
	Если Модель.База.Порядок.Количество() = 0 Тогда
		Если Модель.Свойство("Отношение") Тогда
			РаспределитьПропорциональноЧерезОтношение();
		Иначе
			РаспределитьПропорционально();
		КонецЕсли;
	Иначе
		Если Модель.Свойство("Отношение") Тогда
			РаспределитьПоПорядкуЧерезОтношение();
		Иначе
			РаспределитьПоПорядку();
		КонецЕсли;
	КонецЕсли;
	Инициализировать();
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

Функция СтруктураПоля(Поле, Псевдоним = "") Экспорт
	_Поле = Новый Структура;
	_Поле.Вставить("Поле", Поле);
	_Поле.Вставить("Псевдоним", Псевдоним);
	Возврат _Поле;
КонецФункции

Функция СтруктураИсточника(ИмяИсточника = "", Псевдоним = "") Экспорт
	_Источник = Новый Структура;
	_Источник.Вставить("Источник", ИмяИсточника);
	_Источник.Вставить("Псевдоним", Псевдоним);
	_Источник.Вставить("Порядок", Новый Массив);
	_Источник.Вставить("Отбор", Новый Массив);
	_Источник.Вставить("Автопорядок", Ложь);
	Возврат _Источник;
КонецФункции

Процедура Инициализировать()
	ТипПоля = "";
	ТипИсточника = "";
	Источник = Неопределено;
	Модель = Новый Структура;
КонецПроцедуры

Инициализировать();
Точность = 2;