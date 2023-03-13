Перем Метки;

&НаКлиенте
Процедура КомандаПолучитьТекстМодели(Команда)
	КомандаПолучитьТекстМоделиНаСервере();
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция Псевдоним(ПутьКДанным) 
	Возврат СтрЗаменить(ОбщийКлиентСервер.НачалоСтрокиПослеРазделителя(ПутьКДанным, "."), ".", "");
КонецФункции

&НаСервере
Процедура ДобавитьТекстПоля(Строки, ЗапросПакета, Выражение)
	Колонка = ЗапросПакета.Колонки.Найти(Выражение);
	Поле = Строка(Выражение);
	
	АгрегатнаяФункция = "";
	Если СтрНачинаетсяС(Поле, "СУММА(") Тогда
		АгрегатнаяФункция = "Сумма";
		ЧислоСимволов = 6;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	ИначеЕсли СтрНачинаетсяС(Поле, "КОЛИЧЕСТВО(РАЗЛИЧНЫЕ ") Тогда
		АгрегатнаяФункция = "КоличествоРазличных";
		ЧислоСимволов = 21;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	ИначеЕсли СтрНачинаетсяС(Поле, "КОЛИЧЕСТВО(") Тогда
		АгрегатнаяФункция = "Количество";
		ЧислоСимволов = 11;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	ИначеЕсли СтрНачинаетсяС(Поле, "СРЕДНЕЕ(") Тогда
		АгрегатнаяФункция = "Среднее";
		ЧислоСимволов = 8;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	ИначеЕсли СтрНачинаетсяС(Поле, "МАКСИМУМ(") Тогда
		АгрегатнаяФункция = "Максимум";
		ЧислоСимволов = 9;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	ИначеЕсли СтрНачинаетсяС(Поле, "МИНИМУМ(") Тогда
		АгрегатнаяФункция = "Минимум";
		ЧислоСимволов = 8;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
	КонецЕсли;
	Если ЗначениеЗаполнено(АгрегатнаяФункция) Тогда
		Псевдоним = Псевдоним(Поле);
		Если Колонка.Поля.Количество() = 1 И Псевдоним = Колонка.Псевдоним Тогда
			Строки.Добавить(СтрШаблон(".%1(""%2"")", АгрегатнаяФункция, Поле));
			Возврат;
		КонецЕсли;
		Строки.Добавить(СтрШаблон(".%1(""%2"", ""%3"")", АгрегатнаяФункция, ОбщийКлиентСервер.ЭкранироватьТекст(Поле), Колонка.Псевдоним));
		Возврат;
	КонецЕсли;
	
	Если СтрНачинаетсяС(Поле, "ЕСТЬNULL(") Тогда
		ЧислоСимволов = 9;
		Поле = Сред(Поле, ЧислоСимволов + 1, СтрДлина(Поле) - ЧислоСимволов - 1);
		ПозицияРазделителя = СтрНайти(Поле, ",", НаправлениеПоиска.СКонца);
		ПолеЕстьNull = СокрЛ(Прав(Поле, СтрДлина(Поле) - ПозицияРазделителя));
		Поле = Лев(Поле, ПозицияРазделителя - 1);
		Псевдоним = Псевдоним(Поле);
		Если Колонка.Поля.Количество() = 1 И Псевдоним = Колонка.Псевдоним Тогда
			Строки.Добавить(СтрШаблон(".Поле(""%1"", , ""%2"")", Поле, ПолеЕстьNull));
			Возврат;
		КонецЕсли;
		ДобавитьСтроку(Строки, СтрШаблон(".Поле(""%1"", ""%2"", ""%3"")", ОбщийКлиентСервер.ЭкранироватьТекст(Поле), Колонка.Псевдоним, ОбщийКлиентСервер.ЭкранироватьТекст(ПолеЕстьNull)));
		Возврат;
	КонецЕсли;
	
	Псевдоним = Псевдоним(Строка(Выражение));
	Если Колонка.Поля.Количество() = 1 И Псевдоним = Колонка.Псевдоним Тогда
		ДобавитьСтроку(Строки, СтрШаблон(".Поле(""%1"")", Выражение));
		Возврат;
	КонецЕсли;
	ДобавитьСтроку(Строки, СтрШаблон(".Поле(""%1"", ""%2"")", ОбщийКлиентСервер.ЭкранироватьТекст(Выражение), Колонка.Псевдоним));
КонецПроцедуры

&НаСервере
Процедура ДобавитьТекстСоединения(Строки, СтрокаСоединения, Связи, Условия)
	Если Связи.ВГраница() <> -1 Тогда
		Строки.Добавить(СтрШаблон(".%1(""%2"", ""%3"")", СтрокаСоединения.ТипСоединения, СтрокаСоединения.ИсточникСлева, СтрокаСоединения.ИсточникСправа));
		Строки.Добавить(СтрШаблон("	.Связь(""%1"");", СтрСоединить(Связи, ", ")));
	КонецЕсли; 
	Если Условия.ВГраница() <> -1 Тогда
		Условие = ОбщийКлиентСервер.ЭкранироватьТекст(СтрСоединить(Условия, "
		|И "));
		Условие = СтрЗаменить(Условие, СтрокаСоединения.ИсточникСлева, "%1");
		Условие = СтрЗаменить(Условие, СтрокаСоединения.ИсточникСправа, "%2");
		Если Связи.ВГраница() = -1 Тогда
			ДобавитьСтроку(Строки, СтрШаблон(".%1(""%2"", ""%3"")", СтрокаСоединения.ТипСоединения, СтрокаСоединения.ИсточникСлева, СтрокаСоединения.ИсточникСправа));
		КонецЕсли;
		ДобавитьСтроку(Строки, СтрШаблон("	.УсловиеСвязи(""%1"");", Условие));
	КонецЕсли;
КонецПроцедуры

&НаСервере
Функция ПолучитьТекстЗапроса()
	Перем МодельЗапроса;
	Выполнить(Объект.ТекстМодели.ПолучитьТекст());
	Возврат МодельЗапроса.СхемаЗапроса.ПолучитьТекстЗапроса();
КонецФункции

&НаКлиенте
Процедура КомандаПолучитьТекстЗапроса(Команда)
	Текст = Новый ТекстовыйДокумент;
	Текст.УстановитьТекст(ПолучитьТекстЗапроса());
	Текст.Показать("Текст запроса из модели");
КонецПроцедуры

&НаСервере
Функция ПривестиСтроку(Строка, ОчиститьВызов = Истина, ОчиститьОкончание = Истина)
	Результат = Строка;
	Если ОчиститьВызов Тогда
		Результат = СтрЗаменить(Результат, "МодельЗапроса", "");
	КонецЕсли;		
	Если ОчиститьОкончание Тогда
		Результат = СтрЗаменить(Результат, ";", "");
	КонецЕсли;		
	Возврат Результат;
КонецФункции

&НаСервере
Процедура ДобавитьСтроки(СтрокиПолучателя, СтрокиИсточника, Отступ = 0, ПерваяСтрокаБезОтступа = Ложь, ТекучийИнтерфейс = Ложь)
	СтрокаОтступа1 = СтроковыеФункцииКлиентСервер.СформироватьСтрокуСимволов(Символы.Таб, Отступ);
	СтрокаОтступа = СтроковыеФункцииКлиентСервер.СформироватьСтрокуСимволов(Символы.Таб, Отступ + 1);
	Если ТекучийИнтерфейс Тогда
		Для й = 0 По СтрокиИсточника.ВГраница() Цикл
			Если й = 0 И ПерваяСтрокаБезОтступа Тогда
				ДобавитьСтроку(СтрокиПолучателя, ПривестиСтроку(СтрШаблон("%1%2", СтрокаОтступа1, СтрокиИсточника[й]), Ложь, Истина));
			ИначеЕсли й = СтрокиИсточника.ВГраница() Тогда
				ДобавитьСтроку(СтрокиПолучателя, ПривестиСтроку(СтрШаблон("%1%2", СтрокаОтступа, СтрокиИсточника[й]), Истина, Ложь));
			Иначе
				ДобавитьСтроку(СтрокиПолучателя, ПривестиСтроку(СтрШаблон("%1%2", СтрокаОтступа, СтрокиИсточника[й])));
			КонецЕсли;
		КонецЦикла;
		Возврат;
	КонецЕсли;
	Для й = 0 По СтрокиИсточника.ВГраница() Цикл
		Если й = 0 И ПерваяСтрокаБезОтступа Тогда
			ДобавитьСтроку(СтрокиПолучателя, СтрШаблон("%1", СтрокиИсточника[й]));
		Иначе
			ДобавитьСтроку(СтрокиПолучателя, СтрШаблон("%1%2", СтрокаОтступа, СтрокиИсточника[й]));
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ДобавитьТекстОператора(Строки, ЗапросПакета, ОператорВыбрать, ЭтоПервыйОператор, Уровень = 0)
	Если ЭтоПервыйОператор Тогда
		ИмяМетода = "Выбрать";
	ИначеЕсли ОператорВыбрать.ТипОбъединения = ТипОбъединенияСхемыЗапроса.ОбъединитьВсе Тогда
		ИмяМетода = "ОбъединитьВсе";
	Иначе
		ИмяМетода = "Объединить";
	КонецЕсли;
	Если ОператорВыбрать.КоличествоПолучаемыхЗаписей = Неопределено Тогда
		ВыбратьПервые = "";
	Иначе
		ВыбратьПервые = Формат(ОператорВыбрать.КоличествоПолучаемыхЗаписей, "ЧГ=;");
	КонецЕсли;
	Если ОператорВыбрать.ВыбиратьРазличные Тогда
		Строки.Добавить(СтрШаблон(".%1(%2, Истина)", ИмяМетода, ВыбратьПервые));
	Иначе
		Строки.Добавить(СтрШаблон(".%1(%2)", ИмяМетода, ВыбратьПервые));
	КонецЕсли;

	Для Каждого Источник Из ОператорВыбрать.Источники Цикл
		ТипИсточника = ТипЗнч(Источник.Источник);
		Если ТипИсточника = Тип("ВложенныйЗапросСхемыЗапроса") Тогда
			ВложенныйЗапрос = Источник.Источник.Запрос;
			Строки.Добавить(СтрШаблон(".ИсточникНачать(""%1"")", Источник.Источник.Псевдоним));
			ЭтоПервыйОператорВложенногоЗапроса = Истина;
			СтрокиВложенногоЗапроса = Новый Массив;
			Для Каждого ВложенныйЗапросОператорВыбрать Из ВложенныйЗапрос.Операторы Цикл
				СтрокиОператора = Новый Массив;
				ДобавитьТекстОператора(СтрокиОператора, ВложенныйЗапрос, ВложенныйЗапросОператорВыбрать, ЭтоПервыйОператорВложенногоЗапроса, 0);
				ДобавитьСтроки(СтрокиВложенногоЗапроса, СтрокиОператора, 0, Истина, Истина);
				ЭтоПервыйОператорВложенногоЗапроса = Ложь;						
			КонецЦикла;
			ДобавитьСтроки(Строки, СтрокиВложенногоЗапроса, Уровень);
			Строки.Добавить(СтрШаблон(".ИсточникЗавершить()"));
			Продолжить;
		КонецЕсли;
		ИмяТаблицы = Источник.Источник.ИмяТаблицы;
		Псевдоним = Источник.Источник.Псевдоним;
		Если ТипИсточника = Тип("ОписаниеВременнойТаблицыСхемыЗапроса") Тогда
			Строки.Добавить(СтрШаблон(".Источник(""%1"", ""%2"")", ИмяТаблицы, Псевдоним));
			Продолжить;
		КонецЕсли;					
		СтруктураПараметров = РаботаСоСхемойЗапроса.ПараметрыВиртуальнойТаблицы(ИмяТаблицы, Источник.Источник.Параметры);
		Если СтруктураПараметров = Неопределено Тогда
			Если Псевдоним = ОбщийКлиентСервер.ОкончаниеСтрокиПослеРазделителя(ИмяТаблицы) Тогда
				Строки.Добавить(СтрШаблон(".Источник(""%1"")", ИмяТаблицы));					
			Иначе
				Строки.Добавить(СтрШаблон(".Источник(""%1"", ""%2"")", ИмяТаблицы, Псевдоним));					
			КонецЕсли;
		Иначе
			ОписаниеКлючейПараметров = "";
			СтруктураПараметровБезКоманды = Новый Структура;
			СтрокиПараметров = Новый Массив;
			Для Каждого ЭлементПараметра Из СтруктураПараметров Цикл
				Если ЭлементПараметра.Ключ = "НачалоПериода" Тогда
					СтрокиПараметров.Добавить(СтрШаблон(".НачалоПериода(%1)", СтрокаВКавычках(ЭлементПараметра.Значение)));
				ИначеЕсли ЭлементПараметра.Ключ = "КонецПериода" Тогда
					СтрокиПараметров.Добавить(СтрШаблон(".КонецПериода(%1)", СтрокаВКавычках(ЭлементПараметра.Значение)));
				ИначеЕсли ЭлементПараметра.Ключ = "Период" Тогда
					СтрокиПараметров.Добавить(СтрШаблон(".Период(%1)", СтрокаВКавычках(ЭлементПараметра.Значение)));
				ИначеЕсли ЭлементПараметра.Ключ = "Периодичность" Тогда
					СтрокиПараметров.Добавить(СтрШаблон(".Периодичность%1()", ЭлементПараметра.Значение));
				ИначеЕсли ЭлементПараметра.Ключ = "Условие" Тогда
					СтрокиПараметров.Добавить(СтрШаблон(".Условие(%1)", СтрокаВКавычках(ЭлементПараметра.Значение)));
				Иначе
					ОписаниеКлючейПараметров = ОписаниеКлючейПараметров + ?(ОписаниеКлючейПараметров = "", "", ", ") + ЭлементПараметра.Ключ;
					СтруктураПараметровБезКоманды.Вставить(ЭлементПараметра.Ключ, ЭлементПараметра.Значение);
				КонецЕсли;
			КонецЦикла;
			ОписаниеЗначенийПараметров = "";
			Для Каждого ЭлементПараметра Из СтруктураПараметровБезКоманды Цикл
				ОписаниеЗначенийПараметров = ОписаниеЗначенийПараметров + ?(ОписаниеЗначенийПараметров = "", "", ", ") + """" + ЭлементПараметра.Значение + """";
			КонецЦикла;
			Если ЗначениеЗаполнено(ОписаниеЗначенийПараметров) Тогда
				ПараметрыТаблицы = "Новый Структура(""" + ОписаниеКлючейПараметров + """, " + ОписаниеЗначенийПараметров + ")";
				Строки.Добавить(СтрШаблон("МодельЗапроса.Источник(""%1"", ""%2"", %3);", ИмяТаблицы, Псевдоним, ПараметрыТаблицы));					
			Иначе 
				Если Псевдоним = ОбщийКлиентСервер.ОкончаниеСтрокиПослеРазделителя(ИмяТаблицы) Тогда
					Строки.Добавить(СтрШаблон(".Источник(""%1"")", ИмяТаблицы));					
				Иначе
					Строки.Добавить(СтрШаблон(".Источник(""%1"", ""%2"")", ИмяТаблицы, Псевдоним));					
				КонецЕсли;
			КонецЕсли;
			ДобавитьСтроки(Строки, СтрокиПараметров, 0);
			//Строки.Добавить(СтрШаблон(".Источник(""%1"", ""%2"", %3)", ИмяТаблицы, Псевдоним, ПараметрыТаблицы));					
		КонецЕсли;
	КонецЦикла;
	
	ТаблицаСоединений = Новый ТаблицаЗначений;
	ТаблицаСоединений.Колонки.Добавить("ИсточникСлева");
	ТаблицаСоединений.Колонки.Добавить("ИсточникСправа");
	ТаблицаСоединений.Колонки.Добавить("ТипСоединения");
	ТаблицаСоединений.Колонки.Добавить("ЭтоСвязь", Новый ОписаниеТипов("Булево"));
	ТаблицаСоединений.Колонки.Добавить("Связь");
	ТаблицаСоединений.Колонки.Добавить("УсловиеСвязи");
	
	Для Каждого Источник Из ОператорВыбрать.Источники Цикл
		Для Каждого Соединение Из Источник.Соединения Цикл
			
//////////////////////////////////////////////////

			ТипСоединения = Соединение.ТипСоединения;
			ИсточникСлева = Источник.Источник;
			ИсточникСправа = Соединение.Источник.Источник; 
			Если ТипСоединения = ТипСоединенияСхемыЗапроса.ЛевоеВнешнее Тогда
				МетодСоединения = "ЛевоеСоединение";
			ИначеЕсли ТипСоединения = ТипСоединенияСхемыЗапроса.Внутреннее Тогда
				МетодСоединения = "ВнутреннееСоединение";
			ИначеЕсли ТипСоединения = ТипСоединенияСхемыЗапроса.ПравоеВнешнее Тогда
				МетодСоединения = "ПравоеСоединение";
			ИначеЕсли ТипСоединения = ТипСоединенияСхемыЗапроса.ПолноеВнешнее Тогда
				МетодСоединения = "ПолноеСоединение";
			Иначе
				ВызватьИсключение СтрШаблон("Неизвестный тип соединения %1", ТипСоединения);
			КонецЕсли;
			Условие = Соединение.Условие;
			Связь = Условие;
			ЭтоСвязь = Истина;
			ПоляСвязи = Новый Массив;
			Для Каждого УсловиеСвязи Из СтрРазделить(СтрЗаменить(Связь, " И ", ","), ",") Цикл
				Состав = СтрРазделить(УсловиеСвязи, "=");
				Если Состав.ВГраница() <> 1 Тогда
					ЭтоСвязь = Ложь;
					Прервать
				КонецЕсли;
				ПолеСлева = СокрЛП(Состав[0]);
				ПолеСлева = СтрЗаменить(ПолеСлева, ИсточникСлева.Псевдоним + ".", "");
				ПолеСправа = СокрЛП(Состав[1]);
				ПолеСправа = СтрЗаменить(ПолеСправа, ИсточникСправа.Псевдоним + ".", "");
				Если ИсточникСлева.ДоступныеПоля.Найти(ПолеСлева) = Неопределено Тогда
					ЭтоСвязь = Ложь;
					Прервать
				КонецЕсли;
				Если ИсточникСправа.ДоступныеПоля.Найти(ПолеСправа) = Неопределено Тогда
					ЭтоСвязь = Ложь;
					Прервать
				КонецЕсли;
				Если ПолеСлева = ПолеСправа Тогда
					ПоляСвязи.Добавить(ПолеСлева);
					Продолжить;
				КонецЕсли;
				ПоляСвязи.Добавить(СтрШаблон("%1 = %2", ПолеСлева, ПолеСправа));
			КонецЦикла;
			
			СтрокаСоединения = ТаблицаСоединений.Добавить();
			СтрокаСоединения.ТипСоединения = МетодСоединения;
			СтрокаСоединения.ИсточникСлева = ИсточникСлева.Псевдоним;
			СтрокаСоединения.ИсточникСправа = ИсточникСправа.Псевдоним;
			Если ЭтоСвязь Тогда
				СтрокаСоединения.Связь = СтрСоединить(ПоляСвязи, ", ");
				СтрокаСоединения.ЭтоСвязь = Истина;
				Продолжить;
			КонецЕсли;			
			СтрокаСоединения.УсловиеСвязи = Условие;

//////////////////////////////////////////////////
			
			//ДобавитьТекстСоединения(Строки, Источник, Соединение);
		КонецЦикла;					
	КонецЦикла;
	ТаблицаСоединений.Сортировать("ИсточникСлева, ИсточникСправа, ТипСоединения, ЭтоСвязь Убыв");
	ПредИндекс = "";
	Связи = Новый Массив;
	Условия = Новый Массив;
	ПоляГруппировки = Новый Структура("ТипСоединения, ИсточникСлева, ИсточникСправа");
	Для каждого СтрокаСоединения Из ТаблицаСоединений Цикл
		Индекс = СтрокаСоединения.ТипСоединения + СтрокаСоединения.ИсточникСлева + СтрокаСоединения.ИсточникСправа;
		Если ПредИндекс <> Индекс Тогда
			Если ПредИндекс <> "" Тогда
				ДобавитьТекстСоединения(Строки, ПоляГруппировки, Связи, Условия);
			КонецЕсли;
			Связи = Новый Массив;
			Условия = Новый Массив;
			ПредИндекс = Индекс;
			ЗаполнитьЗначенияСвойств(ПоляГруппировки, СтрокаСоединения);
		КонецЕсли; 
		Если СтрокаСоединения.ЭтоСвязь Тогда
			Связи.Добавить(СтрокаСоединения.Связь);
		Иначе
			Условия.Добавить(СтрокаСоединения.УсловиеСвязи);
		КонецЕсли;
	КонецЦикла; 
	
	ДобавитьТекстСоединения(Строки, СтрокаСоединения, Связи, Условия);
	
	Для Каждого ВыбранноеПоле Из ОператорВыбрать.ВыбираемыеПоля Цикл
		ДобавитьТекстПоля(Строки, ЗапросПакета, ВыбранноеПоле);
	КонецЦикла;
	Для Каждого Выражение Из ОператорВыбрать.Отбор Цикл
		ДобавитьСтроку(Строки, СтрШаблон(".Отбор(""%1"")", ОбщийКлиентСервер.ЭкранироватьТекст(Выражение)));
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ДобавитьТекстПорядка(Строки, ВыражениеПорядка)
	Элемент = ВыражениеПорядка.Элемент;
	Если ТипЗнч(Элемент) = Тип("ВыражениеСхемыЗапроса") Тогда
		Псевдоним = Строка(Элемент);
	Иначе
		Псевдоним = ВыражениеПорядка.Элемент.Псевдоним;//Тип("КолонкаСхемыЗапроса")
	КонецЕсли;
	Если ВыражениеПорядка.Направление = НаправлениеПорядкаСхемыЗапроса.ПоВозрастанию Тогда
		Строки.Добавить(СтрШаблон("	.Порядок(""%1"")", Псевдоним));
	Иначе
		Строки.Добавить(СтрШаблон("	.Порядок(""%1"", НаправлениеПорядкаСхемыЗапроса.%2)", Псевдоним, ОбщийКлиентСервер.CamelCase(Строка(ВыражениеПорядка.Направление))));
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ДобавитьСтроку(Строки, Строка, ПерваяСтрокаБезОтступа = Истина)
	ЭтоПерваяСтрока = Истина;
	Для каждого Подстрока Из СтрРазделить(Строка, Символы.ПС) Цикл
		Если ЭтоПерваяСтрока И ПерваяСтрокаБезОтступа Тогда
			Строки.Добавить(Подстрока);
			ЭтоПерваяСтрока = Ложь;
			Продолжить;
		КонецЕсли;
		Строки.Добавить("	" + Подстрока);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ПрисоединитьСтроку(Строки, Строка, Разделитель = " ")
	ВГраница = Строки.ВГраница();
	Строки[ВГраница] = СтрШаблон("%1%2%3", Строки[ВГраница], Разделитель, Строка);
КонецПроцедуры

&НаСервере
Функция СтрокаВКавычках(Строка)
	Если НЕ ЗначениеЗаполнено(Строка) Тогда
		Возврат "";
	КонецЕсли;
	Возврат СтрШаблон("""%1""", Строка);
КонецФункции

&НаСервере
Процедура ДобавитьТекстЗапроса(Строки, ЗапросПакета)
	Если ТипЗнч(ЗапросПакета) = Тип("ЗапросУничтоженияТаблицыСхемыЗапроса") Тогда
		Строки.Добавить(СтрШаблон(";//  ЗАПРОС УНИЧТОЖЕНИЯ. %1", ЗапросПакета.ИмяТаблицы));
		Строки.Добавить(СтрШаблон("МодельЗапроса.Уничтожить(""%1"")", ЗапросПакета.ИмяТаблицы));
		Возврат;
	КонецЕсли;			
	//  Общее
	ЭтоВременнаяТаблица = НЕ ПустаяСтрока(ЗапросПакета.ТаблицаДляПомещения);
	ДобавитьСтроку(Строки, СтрШаблон(";//  ЗАПРОС ПАКЕТА."));
	Если ЭтоВременнаяТаблица Тогда
		ИмяЗапроса = ЗапросПакета.ТаблицаДляПомещения;
		Метки.Добавить(ИмяЗапроса);
		ПрисоединитьСтроку(Строки, ИмяЗапроса);
		ДобавитьСтроку(Строки, СтрШаблон("МодельЗапроса.ЗапросПакета()"));
	ИначеЕсли ЗапросПакета.Операторы.Количество() = 1 И ЗапросПакета.Операторы[0].Источники.Количество() = 1 Тогда
		ИмяЗапроса = ЗапросПакета.Операторы[0].Источники[0].Источник.Псевдоним;
		Метки.Добавить(ИмяЗапроса);
		ПрисоединитьСтроку(Строки, ИмяЗапроса);
		ДобавитьСтроку(Строки, СтрШаблон("МодельЗапроса.ЗапросПакета(%1)", СтрокаВКавычках(ИмяЗапроса)));
	Иначе 
		ДобавитьСтроку(Строки, СтрШаблон("МодельЗапроса.ЗапросПакета()"));
	КонецЕсли;
	Если ЭтоВременнаяТаблица Тогда
		ПрисоединитьСтроку(Строки, СтрШаблон("Поместить(%1)", СтрокаВКавычках(ЗапросПакета.ТаблицаДляПомещения)), ".");
	КонецЕсли;
	Если ЗапросПакета.ВыбиратьРазрешенные Тогда
		ПрисоединитьСтроку(Строки, "Разрешенные()", ".");
	КонецЕсли;
	ЭтоПервыйОператор = Истина;
	Для Каждого ОператорВыбрать Из ЗапросПакета.Операторы Цикл
		СтрокиОператора = Новый Массив;
		ДобавитьТекстОператора(СтрокиОператора, ЗапросПакета, ОператорВыбрать, ЭтоПервыйОператор);
		ДобавитьСтроки(Строки, СтрокиОператора, 1, Истина, Истина);
		ЭтоПервыйОператор = Ложь;						
	КонецЦикла;
	//  Порядок
	Для Каждого ВыражениеПорядка Из ЗапросПакета.Порядок Цикл
		ДобавитьТекстПорядка(Строки, ВыражениеПорядка);
	КонецЦикла;
	Если ЗапросПакета.Автопорядок Тогда
		Строки.Добавить(СтрШаблон("	.Автопорядок()"));
	КонецЕсли;
	//  Итоги
	Для Каждого КонтрольнаяТочкаИтогов Из ЗапросПакета.КонтрольныеТочкиИтогов Цикл
		Если ТипЗнч(КонтрольнаяТочкаИтогов.Выражение) = Тип("ВыражениеСхемыЗапроса") Тогда
			Выражение = КонтрольнаяТочкаИтогов.Выражение;
		Иначе // КолонкаСхемыЗапроса
			Выражение = КонтрольнаяТочкаИтогов.Выражение.Псевдоним;
		КонецЕсли;
		ИмяКолонкиСовпадаетСВыражением = Строка(Выражение) = КонтрольнаяТочкаИтогов.ИмяКолонки;
		Если КонтрольнаяТочкаИтогов.ТипКонтрольнойТочки = ТипКонтрольнойТочкиСхемыЗапроса.Элементы Тогда
			Если ИмяКолонкиСовпадаетСВыражением Тогда
				Строки.Добавить(СтрШаблон("	.Группировка(""%1"")", Выражение));
			Иначе
				Строки.Добавить(СтрШаблон("	.Группировка(""%1"", ""%2"")", Выражение, КонтрольнаяТочкаИтогов.ИмяКолонки));
			КонецЕсли;
		Иначе
			Если ИмяКолонкиСовпадаетСВыражением Тогда
				Строки.Добавить(СтрШаблон("	.Группировка(""%1"", , ТипКонтрольнойТочкиСхемыЗапроса.%3)", Выражение, , ОбщийКлиентСервер.CamelCase(Строка(КонтрольнаяТочкаИтогов.ТипКонтрольнойТочки))));
			Иначе
				Строки.Добавить(СтрШаблон("	.Группировка(""%1"", ""%2"", ТипКонтрольнойТочкиСхемыЗапроса.%3)", Выражение, КонтрольнаяТочкаИтогов.ИмяКолонки, ОбщийКлиентСервер.CamelCase(Строка(КонтрольнаяТочкаИтогов.ТипКонтрольнойТочки))));
			КонецЕсли;
		КонецЕсли;
		Если КонтрольнаяТочкаИтогов.ТипДополненияПериодами = ТипДополненияПериодамиСхемыЗапроса.БезДополнения Тогда
			Продолжить;
		КонецЕсли;
		Строки.Добавить(СтрШаблон(".ПоПериодам(ТипДополненияПериодамиСхемыЗапроса.%1, ""%2"", ""%3"")", ОбщийКлиентСервер.CamelCase(Строка(КонтрольнаяТочкаИтогов.ТипДополненияПериодами)), КонтрольнаяТочкаИтогов.НачалоПериодаДополнения, КонтрольнаяТочкаИтогов.КонецПериодаДополнения));
	КонецЦикла;
	Для Каждого ВыражениеИтогов Из ЗапросПакета.ВыраженияИтогов Цикл
		Если СтрШаблон("СУММА(%1)", ВыражениеИтогов.Поле.Псевдоним) = Строка(ВыражениеИтогов.Выражение) Тогда
			Строки.Добавить(СтрШаблон("	.ИтогСумма(""%1"")", ВыражениеИтогов.Поле.Псевдоним));
		Иначе
			Строки.Добавить(СтрШаблон("	.Итог(""%1"", ""%2"")", ВыражениеИтогов.Выражение, ВыражениеИтогов.Поле.Псевдоним));
		КонецЕсли;
	КонецЦикла;
	Если ЗапросПакета.ОбщиеИтоги Тогда
		Строки.Добавить(СтрШаблон("	.ОбщиеИтоги()"));
	КонецЕсли;
	//  Индексы
	Для Каждого Индекс Из ЗапросПакета.Индекс Цикл
		Строки.Добавить(СтрШаблон("	.Индекс(""%1"")", Индекс.Выражение.Псевдоним));
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьТестУстановкиПараметров(Строки, СхемаЗапроса)
	Если СхемаЗапроса.НайтиПараметры().Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	Строки.Добавить(";//  Установка параметров");
	Строки.Добавить(СтрШаблон("//МодельЗапроса"));
	Для Каждого Параметр Из СхемаЗапроса.НайтиПараметры() Цикл
		Строки.Добавить(СтрШаблон("//	.Параметр(""%1"", )// %2", Параметр.Имя, Параметр.ТипЗначения));
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура КомандаПолучитьТекстМоделиНаСервере()
	Метки = Новый Массив;
	Строки = Новый Массив;
	Строки.Добавить("МодельЗапроса = Общий.МодельЗапроса();");
	СхемаЗапроса = Новый СхемаЗапроса;
	СхемаЗапроса.УстановитьТекстЗапроса(Объект.ТекстЗапроса.ПолучитьТекст());
	ТекстМодели = Объект.ТекстМодели;
	ТекстМодели.Очистить();
	//  Запросы
	Для Каждого ЗапросПакета Из СхемаЗапроса.ПакетЗапросов Цикл
		ДобавитьТекстЗапроса(Строки, ЗапросПакета);		
	КонецЦикла;
	ДобавитьТестУстановкиПараметров(Строки, СхемаЗапроса);
	Строки.Добавить(";//  Обработка результата");
	Строки.Добавить(СтрШаблон("//МодельЗапроса.ВыполнитьЗапрос();"));
	Для Каждого Метка Из Метки Цикл
		Строки.Добавить(СтрШаблон("//Результат = МодельЗапроса.Результат(""%1"");", Метка));		
	КонецЦикла;
	Объект.ТекстМодели.УстановитьТекст(СтрСоединить(Строки, Символы.ПС));	
КонецПроцедуры

&НаКлиенте
Асинх Процедура ОткрытьКонструкторЗапроса()
	Конструктор			= Новый КонструкторЗапроса;
	Конструктор.Текст	= Объект.ТекстЗапроса.ПолучитьТекст();
	ТекстЗапроса = Ждать Конструктор.ОткрытьАсинх();
	Если ТекстЗапроса <> Неопределено Тогда
		Объект.ТекстЗапроса.УстановитьТекст(ТекстЗапроса);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура КомандаОткрытьКонструкторЗапроса(Команда)
	ОткрытьКонструкторЗапроса();
КонецПроцедуры
