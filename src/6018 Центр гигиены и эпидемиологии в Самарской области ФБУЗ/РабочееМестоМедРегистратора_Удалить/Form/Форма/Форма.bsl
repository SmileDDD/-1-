﻿НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	_ИМЦ_СобытияФормСервер.УстановитьОтборВСпискеПо_ИМЦ_Организация(ЭтаФорма);
	_ИМЦ_СобытияФормСервер.УстановитьОтборВСпискеПоЛаборатории(ЭтаФорма);
	
	// отбор в Списке за текущий день
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ЭтаФорма.Список.Отбор,
															"Дата",
															ВидСравненияКомпоновкиДанных.БольшеИлиРавно,
															НачалоДня(ТекущаяДата()),
															"", //предстваление
															Истина,
															РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	ОбщегоНазначенияКлиентСервер.ДобавитьЭлементКомпоновки(ЭтаФорма.Список.Отбор,
															"Дата",
															ВидСравненияКомпоновкиДанных.МеньшеИлиРавно,
															конецДня(ТекущаяДата()),
															"", //предстваление
															Истина,
															РежимОтображенияЭлементаНастройкиКомпоновкиДанных.Недоступный);
	
КонецПроцедуры

#КонецОбласти

//======================================================================================================================

#Область ОБРАБОТЧИКИ_СОБЫТИЙ_ЭЛЕМЕНТОВ_ФОРМЫ


#КонецОбласти

//======================================================================================================================

#Область ОБРАБОТЧИКИ_СОБЫТИЙ_ЭЛЕМЕНТОВ_ТАБЛИЦЫ_ФОРМЫ_ТЗ_Напраление

&НаКлиенте
Процедура ТЗ_НаправленияФамилияПриИзменении(Элемент)
	
	ТД = Элементы.ТЗ_Направления.ТекущиеДанные; 
	
	Если ТД <> Неопределено Тогда
		
	   ТД.ФИО = ТД.Фамилия  + " " + ТД.Имя + " " + ТД.Отчество;
	   ТД.ФИО = СокрЛП(ТД.ФИО);
	
	КонецЕсли;	
	
	
КонецПроцедуры

&НаКлиенте
Процедура ТЗ_НаправленияПередНачаломДобавления(Элемент, Отказ, Копирование, Родитель, Группа, Параметр)
		
	ЭтаФорма.ТекущийЭлемент = Элементы.ТЗ_НаправленияФамилия;
	
КонецПроцедуры

&НаКлиенте
Процедура ТЗ_НаправленияВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	ВариантыОтвета = Новый СписокЗначений;
	ВариантыОтвета.Добавить("Пациента");
	ВариантыОтвета.Добавить("Талон");
	ВариантыОтвета.Добавить("Направление (Дефектовка)");
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеЗавершенияВопроса", ЭтаФорма, );
	ПоказатьВопрос(ОписаниеОповещения, "Что необходимо открыть?",ВариантыОтвета, );
	 
	  
		
КонецПроцедуры

#КонецОбласти

//======================================================================================================================

#Область ОБРАБОТЧИКИ_КОМАНД

&НаКлиенте
Процедура СоздатьТалонИНапраление(Команда)
	
	ТД = Элементы.ТЗ_Направления.ТекущиеДанные; 
	
	Если ТД <> Неопределено Тогда
		                  		
		СоздатьТалон(ТД.ПолучитьИдентификатор());
		МассивТипов = ПолучитьСписокТиповМетаДанныхПоляНаправление();
		СписокВариантовОтвета = Новый СписокЗначений;
		СписокВариантовОтвета.ЗагрузитьЗначения(МассивТипов);
		
		ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВыбораТипаНаправления", ЭтаФорма, );
		ПоказатьВопрос(ОписаниеОповещения, "Выберите тип направления",СписокВариантовОтвета, );
				
	КонецЕсли;

	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНаправлениеКопированиемПредыдущего(Команда)
	
	ТC = Элементы.ТЗ_Направления.ТекущаяСтрока; 
	ТД = Элементы.ТЗ_Направления.ТекущиеДанные;	
	
	Если ТC <> Неопределено Тогда
		
		СоздатьТалон(ТД.ПолучитьИдентификатор());
		//ТЗ_Направления[0]-1
		
		Если ТC >= 1 Тогда
			ПредыдущаяСтр = ТД.ПолучитьИдентификатор() -1;			
			
			
			НайдПредСтрока = ТЗ_Направления.НайтиПоИдентификатору(ПредыдущаяСтр);
			
			Если НайдПредСтрока <> Неопределено Тогда
				
				Напр = НайдПредСтрока.НАправление;
				Если ЗначениеЗаполнено(Напр) Тогда
					//СоздатьНапралвениеКопированиемПредыдущегоНаСервере(Напр);
					
					ДанныеЗаполенияНаправления = Новый Структура();
					ДанныеЗаполенияНаправления.Вставить("Талон",		ТД.Талон);
					ДанныеЗаполенияНаправления.Вставить("ФизЛицо",		ТД.Пациент);
					ДанныеЗаполенияНаправления.Вставить("Контрагент",	Заявитель);
					ДанныеЗаполенияНаправления.Вставить("Лаборатория",	ТД.Лаборатория);
					ДанныеЗаполенияНаправления.Вставить("Договор", 		Договор);
					ДанныеЗаполенияНаправления.Вставить("ТипФинансирования", );
					
					ОповещиенОЗакрытииНаправления = Новый ОписаниеОповещения("ПослеСозданияНаправления",ЭтаФорма, Новый Структура("ТипДокумента", ТипЗнч(Напр)));
					
					
					Если ТипЗнч(Напр) = Тип("ДокументСсылка._ИМЦ_НаправлениеВирусология") Тогда
						ИмяФормыНаправления  = "Документ._ИМЦ_НаправлениеВирусология.Форма.ФормаДокумента"						
					ИначеЕсли ТипЗнч(Напр) = Тип("ДокументСсылка._ИМЦ_НаправлениеООИ") Тогда
						ИмяФормыНаправления  = "Документ._ИМЦ_НаправлениеООИ.Форма.ФормаДокумента";						
					ИначеЕсли ТипЗнч(Напр) = Тип("ДокументСсылка._ИМЦ_НаправлениеПЦРСанитарное") Тогда
						ИмяФормыНаправления  = "Документ._ИМЦ_НаправлениеПЦРСанитарное.Форма.ФормаДокумента";
					ИначеЕсли ТипЗнч(Напр) = Тип("ДокументСсылка._ИМЦ_НаправлениеНаМикробиологическоеИсследование") Тогда
						ИмяФормыНаправления  = "Документ._ИМЦ_НаправлениеНаМикробиологическоеИсследование.Форма.ФормаДокумента";		
					ИначеЕсли ТипЗнч(Напр) = Тип("ДокументСсылка._ИМЦ_НаправлениеНаИсследованиеПаразитология") Тогда
						ИмяФормыНаправления  = "Документ._ИМЦ_НаправлениеНаИсследованиеПаразитология.Форма.ФормаДокумента";						
					КонецЕсли; 
					
					
					ОткрытьФорму(ИмяФормыНаправления,
						Новый Структура("Основание, ЗначениеКопирования", ДанныеЗаполенияНаправления, Напр),
						ЭтаФорма,
						,
						,
						,
						ОповещиенОЗакрытииНаправления,
						РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
					
				КонецЕсли;

			Иначе				
				
			КонецЕсли;	
		Иначе
			ПоказатьПредупреждение(,"Нет предыдущей строки!",,"Внимание!"); 
		КонецЕсли;	
		
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьДокументДефектовка(Команда)
	
	ТД = Элементы.ТЗ_Направления.ТекущиеДанные; 	
	Если ТД <> Неопределено Тогда
		
		СоздатьТалон(ТД.ПолучитьИдентификатор());
		
		ДанныеЗаполенияНаправления = Новый Структура();
		ДанныеЗаполенияНаправления.Вставить("Талон",		ТД.Талон);
		
		ОповещиенОЗакрытииНаправления = Новый ОписаниеОповещения("ПослеСозданияНаправления",ЭтаФорма, Новый Структура("ТипДокумента", Тип("ДокументСсылка._ИМЦ_ДефектыКлиническогоМатериала")));
		
		ОткрытьФорму("Документ._ИМЦ_ДефектыКлиническогоМатериала.Форма.ФормаДокумента",
			Новый Структура("Основание", ДанныеЗаполенияНаправления),
			ЭтаФорма,
			,
			,
			,
			ОповещиенОЗакрытииНаправления,
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
			
	КонецЕсли;
	
КонецПроцедуры


#КонецОбласти

//======================================================================================================================

#Область СЛУЖЕБНЫЕ_ПРОЦЕДУРЫ_И_ФУНКЦИИ

&НаСервере
Процедура СоздатьТалон(Идентификатор)
	
	ТД = ТЗ_Направления.НайтиПоИдентификатору(Идентификатор);
	
	Если ТД <> Неопределено Тогда
		
		#Область Создание_ФизЛица
		Если Не ЗначениеЗаполнено(ТД.Пациент) Тогда
			
			НовыйЭлемент = Справочники._ИМЦ_ФизическиеЛица.СоздатьЭлемент();
			НовыйЭлемент.Наименование	= ТД.фамилия + " " + ТД.Имя + " " + ТД.Отчество;
			НовыйЭлемент.Фамилия		= ТД.фамилия;
			НовыйЭлемент.Имя			= ТД.Имя;
			НовыйЭлемент.Отчество		= ТД.Отчество; 
			НовыйЭлемент.ДатаРождения	= ТД.ДатаРождения;
			НовыйЭлемент.Пол 			= ТД.Пол;  		 
			
			НовыйЭлемент.Записать();
			
			ТД.Пациент = НовыйЭлемент.Ссылка;
		КонецЕсли;
		
		#КонецОбласти
		
		#Область Создание_талона
		
		Если Не ЗначениеЗаполнено(ТД.Талон) Тогда
			
			НовТалон = Справочники._ИМЦ_ТалонНаКлиническоеИсследование.СоздатьЭлемент();
			НовТалон.ФизическоеЛицо		= ТД.Пациент;
			НовТалон._ИМЦ_Организация	= ПараметрыСеанса.ТекущийПользователь._ИМЦ_Организация;
			НовТалон.Лаборатория		= ТД.Лаборатория;
			НовТалон.Дата				= ТекущаяДата();
			НовТалон.Заявитель			= Заявитель;
			НовТалон.Ответственный		= ПараметрыСеанса.ТекущийПользователь;
			НовТалон.Договор			= Договор;
			НовТалон.Записать();
			
			ТД.Талон = НовТалон.Ссылка;
		КонецЕсли;

		
		#КонецОбласти
		
	КонецЕсли;	
		
КонецПроцедуры

&НаСервере
Функция ПолучитьСписокТиповМетаДанныхПоляНаправление()
	
	ТЗ = ДанныеФормыВЗначение(ТЗ_Направления, Тип("ТаблицаЗначений"));
	МассивТипов = ТЗ.Колонки.Найти("Направление").ТипЗначения.Типы();
	//ТЗ_Направления.	
	Возврат МассивТипов;
	
КонецФункции

&НаКлиенте
Процедура ПослеСозданияНаправления(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	ТД = Элементы.ТЗ_Направления.ТекущиеДанные; 
	
	Если ТД <> Неопределено Тогда
		
	    Направление 	= ПолучитьПоследенееНаправление(ТД.Талон, ДополнительныеПараметры);
		ТД.Направление 	= Направление;
	
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораТипаНаправления(ОтветНаВопрос, ДополнительныеПараметры) Экспорт
	
	ТД = Элементы.ТЗ_Направления.ТекущиеДанные; 
	
	Если ТД <> Неопределено Тогда
		
		ДанныеЗаполенияНаправления = Новый Структура();
		ДанныеЗаполенияНаправления.Вставить("Талон",		ТД.Талон);
		ДанныеЗаполенияНаправления.Вставить("ФизЛицо",		ТД.Пациент);
		ДанныеЗаполенияНаправления.Вставить("Контрагент",	Заявитель);
		ДанныеЗаполенияНаправления.Вставить("Лаборатория",	ТД.Лаборатория);
		ДанныеЗаполенияНаправления.Вставить("Договор", 		Договор);
		ДанныеЗаполенияНаправления.Вставить("ТипФинансирования", );
		
		ОповещиенОЗакрытииНаправления = Новый ОписаниеОповещения("ПослеСозданияНаправления",ЭтаФорма, Новый Структура("ТипДокумента", ОтветНаВопрос));
		
		Если ОтветНаВопрос = Тип("ДокументСсылка._ИМЦ_НаправлениеВирусология") Тогда
			ИмяДокумента = "_ИМЦ_НаправлениеВирусология";
		ИначеЕсли ОтветНаВопрос = Тип("ДокументСсылка._ИМЦ_НаправлениеООИ") Тогда
			ИмяДокумента = "_ИМЦ_НаправлениеООИ";
		ИначеЕсли ОтветНаВопрос = Тип("ДокументСсылка._ИМЦ_НаправлениеПЦРСанитарное") Тогда
			ИмяДокумента = "_ИМЦ_НаправлениеПЦРСанитарное";
		ИначеЕсли ОтветНаВопрос = Тип("ДокументСсылка._ИМЦ_НаправлениеНаМикробиологическоеИсследование") Тогда
			ИмяДокумента = "_ИМЦ_НаправлениеНаМикробиологическоеИсследование";
			ДанныеЗаполенияНаправления.Вставить("ФизическоеЛицо", ТД.Пациент);
		ИначеЕсли ОтветНаВопрос = Тип("ДокументСсылка._ИМЦ_НаправлениеНаИсследованиеПаразитология") Тогда
			ИмяДокумента = "_ИМЦ_НаправлениеНаИсследованиеПаразитология";
		КонецЕсли;

		ОткрытьФорму("Документ." + ИмяДокумента + ".Форма.ФормаДокумента",
			Новый Структура("Основание", ДанныеЗаполенияНаправления),
			ЭтаФорма,
			,
			,
			,
			ОповещиенОЗакрытииНаправления,
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ПолучитьПоследенееНаправление(Талон, ДополнительныеПараметры)
	
	
	Если ДополнительныеПараметры.ТипДокумента = Тип("ДокументСсылка._ИМЦ_НаправлениеВирусология") Тогда
		Документ  = "_ИМЦ_НаправлениеВирусология";
		
	ИначеЕсли ДополнительныеПараметры.ТипДокумента = Тип("ДокументСсылка._ИМЦ_НаправлениеООИ") Тогда
		Документ  = "_ИМЦ_НаправлениеООИ";
		
	ИначеЕсли ДополнительныеПараметры.ТипДокумента = Тип("ДокументСсылка._ИМЦ_НаправлениеПЦРСанитарное") Тогда
		Документ  = "_ИМЦ_НаправлениеПЦРСанитарное";
		
	ИначеЕсли ДополнительныеПараметры.ТипДокумента = Тип("ДокументСсылка._ИМЦ_НаправлениеНаМикробиологическоеИсследование") Тогда
		Документ  = "_ИМЦ_НаправлениеНаМикробиологическоеИсследование";
		
	ИначеЕсли ДополнительныеПараметры.ТипДокумента = Тип("ДокументСсылка._ИМЦ_НаправлениеНаИсследованиеПаразитология") Тогда
		Документ  = "_ИМЦ_НаправлениеНаИсследованиеПаразитология";
	ИначеЕсли ДополнительныеПараметры.ТипДокумента = Тип("ДокументСсылка._ИМЦ_ДефектыКлиническогоМатериала") Тогда
		Документ  = "_ИМЦ_ДефектыКлиническогоМатериала";
		
		
	КонецЕсли; 
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	Направление.Ссылка
	|ИЗ
	|	Документ." + Документ + " КАК Направление
	|ГДЕ
	|	Направление.Талон = &Талон ";
	
	Запрос.УстановитьПараметр("Талон", Талон);
	
	Результат =  Запрос.Выполнить().Выгрузить(); 
	Если Результат.Количество() Тогда
		Возврат Результат[0].Ссылка;
	КонецЕсли;
	
	
КонецФункции

&НаКлиенте
Процедура ПослеЗавершенияВопроса(ОтветНаВопрос, ДополнительныеПараметры) Экспорт
	
	ТД = Элементы.ТЗ_Направления.ТекущиеДанные; 
	
	Если ТД <> Неопределено Тогда
		
		Если ОтветНаВопрос = "Пациента" Тогда
			
			ОткрытьЗначение(ТД.Пациент);
			
		ИначеЕсли ОтветНаВопрос = "Талон" Тогда
			
			ОткрытьЗначение(ТД.Талон);
			
		ИначеЕсли ОтветНаВопрос = "Направление (Дефектовка)" Тогда
			
			ОткрытьЗначение(ТД.Направление); 			 
			
		КонецЕсли; 
		
		
	КонецЕсли;	
	
КонецПроцедуры


#КонецОбласти

//======================================================================================================================


#КонецОбласти

#Область Физ_лица

//======================================================================================================================

#Область ОБРАБОТЧИКИ_СОБЫТИЙ_ЭЛЕМЕНТОВ_ФОРМЫ

#КонецОбласти

//======================================================================================================================

#Область ОБРАБОТЧИКИ_КОМАНД

&НаКлиенте
Процедура СоздатьПриложениеФизЛицо(Команда)
	 
	 СоздатьТалонФизЛицо();
	 
	 Если Не ЗначениеЗаполнено(ПриложениеФизЛицо) Тогда
		 ОписаниеОповещения = Новый ОписаниеОповещения("ПослеЗаписиПриложения", ЭтаФорма );
		 
		 ПараметрыФормы = Новый Структура("Договор", ДоговорФизЛицо); 
		 ОткрытьФорму("Документ._ИМЦ_ПриложенияКДоговорам.Форма.ФормаДокумента",
		 	ПараметрыФормы ,
			ЭтаФорма,
			,
			,
			,
			ОписаниеОповещения, 
			РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		 
	КонецЕсли;


 КонецПроцедуры

#КонецОбласти

//======================================================================================================================

#Область СЛУЖЕБНЫЕ_ПРОЦЕДУРЫ_И_ФУНКЦИИ

&НаСервере
Процедура СоздатьТалонФизЛицо()
	
	#Область Создание_ФизЛица
	Если Не ЗначениеЗаполнено(Пациент) Тогда
		
		НовыйЭлемент = Справочники._ИМЦ_ФизическиеЛица.СоздатьЭлемент();
		НовыйЭлемент.Наименование	= фамилия + " " + Имя + " " + Отчество;
		НовыйЭлемент.Фамилия		= фамилия;
		НовыйЭлемент.Имя			= Имя;
		НовыйЭлемент.Отчество		= Отчество; 
		НовыйЭлемент.ДатаРождения	= ДатаРождения;
		НовыйЭлемент.Пол 			= ПолФизЛица;  		 
		
		НовыйЭлемент.Записать();
		
		Пациент = НовыйЭлемент.Ссылка;
		
		Элементы.Фамилия.ТолькоПросмотр 		= Истина;
		Элементы.Имя.ТолькоПросмотр 			= Истина;
		Элементы.Отчество.ТолькоПросмотр 		= Истина;
		Элементы.ПолФизЛица.ТолькоПросмотр 		= Истина;
		Элементы.ДатаРождения.ТолькоПросмотр 	= Истина;
		Элементы.ПаспортСерия.ТолькоПросмотр 	= Истина;
		Элементы.ПаспортНомер.ТолькоПросмотр 	= Истина;
		Элементы.ПаспортКемВыдан.ТолькоПросмотр = Истина;
		Элементы.ПаспортКогдаВыдан.ТолькоПросмотр = Истина;
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область ФизЛицо_Контрагент
	
	Если Не ЗначениеЗаполнено(ЗаявительФизЛицо) Тогда
		НовКонтр = Справочники._ИМЦ_Контрагенты.СоздатьЭлемент();
		НовКонтр._ИМЦ_Организация = ПараметрыСеанса.ТекущийПользователь._ИМЦ_Организация;
		НовКонтр.ПаспортВыдан = ПаспортКемВыдан;
		НовКонтр.ПаспортСерия = ПаспортСерия;
		НовКонтр.ПаспортНомер = ПаспортНомер;
		НовКонтр.Наименование = фамилия + " " + Имя + " " + Отчество;
		//НовКонтр.Родитель     = 
		НовКонтр.ВидКонтрагента = Перечисления._ИМЦ_ВидыКонтрагентов.ФизЛицо;
		
		НовКонтр.Записать();
		ЗаявительФизЛицо = НовКонтр.Ссылка;
		
	КонецЕсли;
	#КонецОбласти
	
	#Область Договор
	
	Если Не ЗначениеЗаполнено(ДоговорФизЛицо) Тогда
		
		НовДоговор = Справочники._ИМЦ_Договора.СоздатьЭлемент();
		НовДоговор.Ответственный 	= ПараметрыСеанса.ТекущийПользователь;
		НовДоговор.ДатаДоговора  	= ТекущаяДата();
		НовДоговор.ВидДоговора 		= Справочники._ИМЦ_ВидыДоговоров.НайтиПоНаименованию("с частными лицами");
		НовДоговор._ИМЦ_Организация = ПараметрыСеанса.ТекущийПользователь._ИМЦ_Организация;
		НовДоговор.Владелец 		= ЗаявительФизЛицо;
		НовДоговор.ВидОбязательства = "Договор";
		НовДоговор.ТипЦен			= Константы._ИМЦ_ТипЦенПоУмолчанию.Получить();
		НовДоговор.ЛабораторияИнициатор = ПараметрыСеанса.ТекущийПользователь.Лаборатория;
		
		//НовДоговор.КраткоеСодержание = 
		НовДоговор.Записать();
		ДоговорФизЛицо = НовДоговор.Ссылка;
		
	КонецЕсли;
	
	#КонецОбласти
	
	#Область Создание_талона
	
	Если Не ЗначениеЗаполнено(ТалонФизЛицо) Тогда
		
		НовТалон = Справочники._ИМЦ_ТалонНаКлиническоеИсследование.СоздатьЭлемент();
		НовТалон.ФизическоеЛицо		= Пациент;
		НовТалон._ИМЦ_Организация	= ПараметрыСеанса.ТекущийПользователь._ИМЦ_Организация;
		НовТалон.Лаборатория		= ЛабораторияФизЛицо;
		НовТалон.Дата				= ТекущаяДата();
		НовТалон.Заявитель			= Заявитель;
		НовТалон.Ответственный		= ПараметрыСеанса.ТекущийПользователь;
		НовТалон.Договор			= ДоговорФизЛицо;
		НовТалон.Записать();
		
		ТалонФизЛицо = НовТалон.Ссылка;
	КонецЕсли;
	
	#КонецОбласти
	
	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписиПриложения(Результат, ДополнительныеПараметры) Экспорт
	
	ПолучитьПриложениеПоДоговору();	
	
	СоздатьНаправление();
	
КонецПроцедуры

&НаСервере
Процедура ПолучитьПриложениеПоДоговору()
	
	 Запрос = Новый Запрос;
	 Запрос.Текст = "ВЫБРАТЬ
	|	_ИМЦ_ПриложенияКДоговорам.Ссылка
	|ИЗ
	|	Документ._ИМЦ_ПриложенияКДоговорам КАК _ИМЦ_ПриложенияКДоговорам
	|ГДЕ
	|	_ИМЦ_ПриложенияКДоговорам.Договор = &Договор";
	
	 Запрос.УстановитьПараметр("Договор", ДоговорФизЛицо );
	
	Результат =  Запрос.Выполнить().Выгрузить();
	Если Результат.Количество() Тогда
		ПриложениеФизЛицо = Результат[0].Ссылка;
	КонецЕсли;	
	
	
КонецПроцедуры

&НаКлиенте
Процедура СоздатьНаправление()
	
	МассивТипов = ПолучитьСписокТиповМетаДанныхПоляНаправление();
	СписокВариантовОтвета = Новый СписокЗначений;
	СписокВариантовОтвета.ЗагрузитьЗначения(МассивТипов);
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВыбораТипаНаправленияФизЛицо", ЭтаФорма, );
	ПоказатьВопрос(ОписаниеОповещения, "Выберите тип направления",СписокВариантовОтвета, );
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораТипаНаправленияФизЛицо(ОтветНаВопрос, ДополнительныеПараметры) Экспорт

	
	ДанныеЗаполенияНаправления	= Новый Структура();
	ДанныеЗаполенияНаправления.Вставить("Талон",          ТалонФизЛицо);
	ДанныеЗаполенияНаправления.Вставить("ФизЛицо",        Пациент);
	ДанныеЗаполенияНаправления.Вставить("Контрагент",     ЗаявительФизЛицо);
	ДанныеЗаполенияНаправления.Вставить("Лаборатория",    ЛабораторияФизЛицо);
	
	ОповещиенОЗакрытииНаправления = Новый ОписаниеОповещения("ПослеСозданияНаправленияФизЛицо",ЭтаФорма, Новый Структура("ТипДокумента", ОтветНаВопрос));
	
	Если ОтветНаВопрос = Тип("ДокументСсылка._ИМЦ_НаправлениеВирусология") Тогда
		ИмяДокумента = "_ИМЦ_НаправлениеВирусология";
	ИначеЕсли ОтветНаВопрос = Тип("ДокументСсылка._ИМЦ_НаправлениеООИ") Тогда
		ИмяДокумента = "_ИМЦ_НаправлениеООИ";
	ИначеЕсли ОтветНаВопрос = Тип("ДокументСсылка._ИМЦ_НаправлениеПЦРСанитарное") Тогда
		ИмяДокумента = "_ИМЦ_НаправлениеПЦРСанитарное";
	ИначеЕсли ОтветНаВопрос = Тип("ДокументСсылка._ИМЦ_НаправлениеНаМикробиологическоеИсследование") Тогда
		ИмяДокумента = "_ИМЦ_НаправлениеНаМикробиологическоеИсследование";
	ИначеЕсли ОтветНаВопрос = Тип("ДокументСсылка._ИМЦ_НаправлениеНаИсследованиеПаразитология") Тогда
		ИмяДокумента = "_ИМЦ_НаправлениеНаИсследованиеПаразитология";
	КонецЕсли;
	
	ОткрытьФорму("Документ." + ИмяДокумента +".Форма.ФормаДокумента",
		Новый Структура("Основание, ЗначенияЗаполнения", ПриложениеФизЛицо, ДанныеЗаполенияНаправления),
		ЭтаФорма,
		,
		,
		,
		ОповещиенОЗакрытииНаправления,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);


КонецПроцедуры

&НаКлиенте
Процедура ОчиститьДанныеЮрЛицо(Команда)
	
	Фамилия				= "";
	Имя					= "";
	Отчество			= "";
	ПолФизЛица			= "";
	ДатаРождения		= Дата(1,1,1,1,1,1);
	ПаспортСерия		= "";
	ПаспортНомер		= "";
	ПаспортКемВыдан		= "";
	ПаспортКогдаВыдан	= Дата(1,1,1,1,1,1);
	Пациент				= "";
	ДоговорФизЛицо		= "";
	ПриложениеФизЛицо	= "";
	ЗаявительФизЛицо	= "";
	ТалонФизЛицо		= "";
	ЛабораторияФизЛицо	= "";
	НаправлениеФизЛицо	= "";
	
	Элементы.Фамилия.ТолькоПросмотр = Ложь;
	Элементы.Имя.ТолькоПросмотр = Ложь;
	Элементы.Отчество.ТолькоПросмотр = Ложь;
	Элементы.ПолФизЛица.ТолькоПросмотр = Ложь;
	Элементы.ДатаРождения.ТолькоПросмотр = Ложь;
	Элементы.ПаспортСерия.ТолькоПросмотр = Ложь;
	Элементы.ПаспортНомер.ТолькоПросмотр = Ложь;
	Элементы.ПаспортКемВыдан.ТолькоПросмотр = Ложь;
	Элементы.ПаспортКогдаВыдан.ТолькоПросмотр = Ложь;
		
	
	
КонецПроцедуры

&НаКлиенте
Процедура РаспечататьДокументы(Команда)
	
	ИменаКоманд = ИменаКомандПечати();
	
	Если ЗначениеЗаполнено(ИменаКоманд.ДоговорФизЛицо) и ЗначениеЗаполнено(ДоговорФизЛицо)Тогда
		_ИМЦ_СобытияФормКлиент.ОбработкаНажатияНаКнопкуДопОтчетов(ДоговорФизЛицо, ЭтаФорма, ИменаКоманд.ДоговорФизЛицо);	    
	Иначе	
		ПоказатьПредупреждение(,"Не установлена команда печати договора!",,"Внимание!" );
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИменаКоманд.Приложение) и ЗначениеЗаполнено(ПриложениеФизЛицо) Тогда
		_ИМЦ_СобытияФормКлиент.ОбработкаНажатияНаКнопкуДопОтчетов(ПриложениеФизЛицо, ЭтаФорма, ИменаКоманд.Приложение);
	Иначе	
		ПоказатьПредупреждение(,"Не установлена команда печати приложения!",,"Внимание!" );
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ИменаКоманд.СправкаСчет) и ЗначениеЗаполнено(СправкаСчетФизЛицо) Тогда
		_ИМЦ_СобытияФормКлиент.ОбработкаНажатияНаКнопкуДопОтчетов(СправкаСчетФизЛицо, ЭтаФорма, ИменаКоманд.СправкаСчет);
	Иначе	
		ПоказатьПредупреждение(,"Не установлена команда печати справки счет!",,"Внимание!" );
	КонецЕсли;

	
КонецПроцедуры

&Насервере
Функция ИменаКомандПечати()
	
	ИмяКомандыПечатиДоговораФизЛица = "";
	ИмяКомандыПечатиПриложения 		= "";	
	ИменаКоманд = Новый Структура("ДоговорФизЛицо, Приложение, СправкаСчет");
	
	Если ЗначениеЗаполнено(ОбработПечатиДоговора) Тогда
		ИменаКоманд.ДоговорФизЛицо = "ЩелчокПоКнопкеДопОтчетов_" + СтрЗаменить(строка(ОбработПечатиДоговора.УникальныйИдентификатор()),"-","_");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ОбработкаПечатиПриложения) Тогда
		ИменаКоманд.Приложение		= "ЩелчокПоКнопкеДопОтчетов_" + СтрЗаменить(строка(ОбработкаПечатиПриложения.УникальныйИдентификатор()),"-","_");
	КонецЕсли;
	              		
	Если ЗначениеЗаполнено(ОбработкаПечатиСпракиСчет) Тогда
		ИменаКоманд.СправкаСчет		= "ЩелчокПоКнопкеДопОтчетов_" + СтрЗаменить(строка(ОбработкаПечатиСпракиСчет.УникальныйИдентификатор()),"-","_");
	КонецЕсли;
	
	Возврат ИменаКоманд;
	
КонецФункции

&НаКлиенте
Процедура ПослеСозданияНаправленияФизЛицо(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	ПолучитьПоследенееНаправление(ТалонФизЛицо, ДополнительныеПараметры);

	СоздатьСправкуСчетНаОснованииПриложения();
КонецПроцедуры

&НаКлиенте
Процедура СоздатьСправкуСчетНаОснованииПриложения()
	
	ПараметрыФормы = Новый Структура("Основание", ПриложениеФизЛицо);
	ОповещениеОЗакрытииСправкиСчет = Новый ОписаниеОповещения("ПослеСозданияСправкиСчет",ЭтаФорма); 
	ОткрытьФорму("Документ._ИМЦ_СправкаСчет.Форма.ФормаДокумента",ПараметрыФормы,ЭтаФорма,,,,ОповещениеОЗакрытииСправкиСчет);	
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеСозданияСправкиСчет(РезультатЗакрытия, ДополнительныеПараметры) Экспорт
	
	ПолучитьПоследнююСправкуСчет();
	
КонецПроцедуры

&НаСервере
Процедура ПолучитьПоследнююСправкуСчет()
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	_ИМЦ_СправкаСчет.Ссылка
	|ИЗ
	|	Документ._ИМЦ_СправкаСчет КАК _ИМЦ_СправкаСчет
	|ГДЕ
	|	_ИМЦ_СправкаСчет.Договор = &Договор";
	
	Запрос.УстановитьПараметр("Договор", ДоговорФизЛицо );
	
	Результат =  Запрос.Выполнить().Выгрузить();
	Если Результат.Количество() Тогда
		СправкаСчетФизЛицо = Результат[0].Ссылка;
	КонецЕсли;	
	
	
КонецПроцедуры


#КонецОбласти

//======================================================================================================================


#КонецОбласти