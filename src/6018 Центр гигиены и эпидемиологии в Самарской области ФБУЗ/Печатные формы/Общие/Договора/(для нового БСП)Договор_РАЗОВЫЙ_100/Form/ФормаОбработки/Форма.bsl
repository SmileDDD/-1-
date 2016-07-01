﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("СсылкаНаОбъект") Тогда		
		Объект.СсылкаНаОбъект = Параметры.СсылкаНаОбъект;  		
	КонецЕсли
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ЗначениеЗаполнено(Объект.СсылкаНаОбъект) Тогда
		
		Отказ = Истина;
		
		ПарамФормы = Новый Структура("СсылкаНаОбъект",Объект.СсылкаНаОбъект);  		
		//ОткрытьФормуМодально("ВнешняяОбработка.ПечатьДоговора.Форма.ФормаЗаказчик",ПарамФормы,ЭтаФорма); 	
		//ОткрытьФормуМодально("ВнешняяОбработка.ПечатьДоговора.Форма.ФормаИсполнитель",,ЭтаФорма); 
		ОткрытьФормуМодально("ВнешняяОбработка.ПечатьДоговора.Форма.ФормаПараметрыДоговора",ПарамФормы,ЭтаФорма);
		
		Если НЕ Объект.ОтменаПечати  Тогда
			
			ТабДок = ФормированиеДоговора(Объект.СсылкаНаОбъект);
			//ТабДок.Показать();
			Если ТабДок <> Неопределено  Тогда 
								
				_ИМЦ_МодульФайлыПечатьКлиент.СозданиеФайлаПриПечатиИзВнешнихОбработок(ТабДок,Объект.ССылкаНаОбъект, ПрефиксНаименованияФайла, ЭтаФорма);
		
			Иначе
				Предупреждение("Нет такого шаблона! Обратитесь за помощью к администратору.");  		
			КонецЕсли;
			
		КонецЕсли;
	КонецЕсли;
	
	
КонецПроцедуры

&НаКлиенте
Процедура Команда1(Команда)
	
	ПарамФормы = Новый Структура("СсылкаНаОбъект",Объект.СсылкаНаОбъект);  		
	//ОткрытьФормуМодально("ВнешняяОбработка.ПечатьДоговора.Форма.ФормаЗаказчик",ПарамФормы,ЭтаФорма); 	
	//ОткрытьФормуМодально("ВнешняяОбработка.ПечатьДоговора.Форма.ФормаИсполнитель",,ЭтаФорма); 
	  ОткрытьФормуМодально("ВнешняяОбработка.ПечатьДоговора.Форма.ФормаПараметрыДоговора",ПарамФормы,ЭтаФорма);
	
	Если НЕ Объект.ОтменаПечати  Тогда
		ТабДок = ФормированиеДоговора(Объект.СсылкаНаОбъект);
		Если ТабДок <> Неопределено  Тогда 
			
			//ТабДок.Показать();
			_ИМЦ_МодульФайлыПечатьКлиент.СозданиеФайлаПриПечатиИзВнешнихОбработок(ТабДок,Объект.ССылкаНаОбъект, ПрефиксНаименованияФайла, ЭтаФорма, "");
			
		Иначе
			Предупреждение("Нет такого шаблона! Обратитесь за помощью к администратору.");    
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	мСтрукт = ВыбранноеЗначение;
	
	Если мСтрукт.Свойство("ОтменаПечати") Тогда
		
		Объект.ОтменаПечати = Истина;
		
	Иначе
		
		Объект.ФИОРукЗаказчикаИмПад =  мСтрукт.ФИОРукЗаказчикаИмПад;
		Объект.ФИОРукЗаказчикаРодП  =  мСтрукт.ФИОРукЗаказчикаРодП;
		Объект.ДолжностьЗаказчика   =  мСтрукт.ДолжностьЗаказчика;
		Объект.ОснованиеЗаказчика   =  мСтрукт.ОснованиеЗаказчика;		     		
		Объект.ФИОИсполнитель       = мСтрукт.ФИОИсполнитель;
		Объект.ИсполнительПодписывающий = мСтрукт.ИсполнительПодписывающий;
		   		
		Объект.ФЗ223    = мСтрукт.ФЗ223;
		Объект.ФЗ44     = мСтрукт.ФЗ44;	
		Объект.Контракт = мСтрукт.Контракт;
		Объект.ИндДоз   = мСтрукт.ИндДоз;
		Объект.ОтменаПечати = Ложь;
		//Объект.ДвусторонняяПечать = мСтрукт.ДвусторонняяПечать;
		
	КонецЕсли;

	//Если мСтрукт.Свойство("ФИОРукЗаказчикаИмПад") Тогда
	//	
	//	Объект.ФИОРукЗаказчикаИмПад =  мСтрукт.ФИОРукЗаказчикаИмПад;
	//	Объект.ФИОРукЗаказчикаРодП  =  мСтрукт.ФИОРукЗаказчикаРодП;
	//	Объект.ДолжностьЗаказчика   =  мСтрукт.ДолжностьЗаказчика;
	//	Объект.ОснованиеЗаказчика   =  мСтрукт.ОснованиеЗаказчика;
	//	
	//Иначе
	//	
	//	Объект.ФИОИсполнитель           = мСтрукт.ФИОИсполнитель;
	//	Объект.ИсполнительПодписывающий = мСтрукт.ИсполнительПодписывающий;
	//	
	//КонецЕсли;
	//
КонецПроцедуры

&НаСервере
Функция ФормированиеДоговора(СсылкаДокумент)
	
	ПрефиксНаименованияФайла = СсылкаДокумент.Наименование;
	
	ТабДок = Новый ТабличныйДокумент;
	
	ДанныйОбъект         = РеквизитФормыВЗначение("Объект"); 
	Макет              = ДанныйОбъект.ПолучитьМакет("Макет"); 
	//ОбластьЗаголовок   = Макет.ПолучитьОбласть("Документ");
	
	#Область Задание_областей_макета
	
	ОбластьШапка   = Макет.ПолучитьОбласть("Шапка");
	Область1   = Макет.ПолучитьОбласть("Область1");
	Область2   = Макет.ПолучитьОбласть("Область2");   	
	Область3   = Макет.ПолучитьОбласть("Область3");  
	Область31  = Макет.ПолучитьОбласть("Область31"); 
	Область32  = Макет.ПолучитьОбласть("Область32");
	Область33  = Макет.ПолучитьОбласть("Область33");    
	Область34  = Макет.ПолучитьОбласть("Область34");    
	Область35  = Макет.ПолучитьОбласть("Область35");    
	Область4   = Макет.ПолучитьОбласть("Область4");    
	Область41  = Макет.ПолучитьОбласть("Область41");    
	Область42  = Макет.ПолучитьОбласть("Область42");  
	Область43  = Макет.ПолучитьОбласть("Область43");  
	Область5   = Макет.ПолучитьОбласть("Область5");  
	Область51  = Макет.ПолучитьОбласть("Область51");  
	Область52  = Макет.ПолучитьОбласть("Область52");  
	Область6   = Макет.ПолучитьОбласть("Область6"); 
	Область61  = Макет.ПолучитьОбласть("Область61");
	Область62  = Макет.ПолучитьОбласть("Область62"); 
	Область63  = Макет.ПолучитьОбласть("Область63"); 
	Область64  = Макет.ПолучитьОбласть("Область64"); 
	Область7   = Макет.ПолучитьОбласть("Область7"); 
	Область71  = Макет.ПолучитьОбласть("Область71"); 
	Область72  = Макет.ПолучитьОбласть("Область72"); 
	Область73  = Макет.ПолучитьОбласть("Область73");
	Область8   = Макет.ПолучитьОбласть("Область8"); 
	Область81  = Макет.ПолучитьОбласть("Область81");  
	Область82  = Макет.ПолучитьОбласть("Область82"); 
	Область83  = Макет.ПолучитьОбласть("Область83");
	Область84  = Макет.ПолучитьОбласть("Область84");
	Область85  = Макет.ПолучитьОбласть("Область85");
	Область9   = Макет.ПолучитьОбласть("Область9");  
	Область91  = Макет.ПолучитьОбласть("Область91"); 
	Область92  = Макет.ПолучитьОбласть("Область92");
	Область93  = Макет.ПолучитьОбласть("Область93"); 
	Область94  = Макет.ПолучитьОбласть("Область94");  
	Область95  = Макет.ПолучитьОбласть("Область95"); 
	Область10  = Макет.ПолучитьОбласть("Область10");
	Область101 = Макет.ПолучитьОбласть("Область101");
	Область102 = Макет.ПолучитьОбласть("Область102");
	Область103 = Макет.ПолучитьОбласть("Область103");
	Область104 = Макет.ПолучитьОбласть("Область104");
	Область105 = Макет.ПолучитьОбласть("Область105");
	Область11  = Макет.ПолучитьОбласть("Область11");
	ОбластьРеквизиты   = Макет.ПолучитьОбласть("Реквизиты");       
	
	#КонецОбласти

	
	
	ОбластьШапка.Параметры.НомерДоговора = СсылкаДокумент.НомерДоговора;
	ОбластьШапка.Параметры.ДатаДоговора = Формат(СсылкаДокумент.ДатаДоговора,"ДФ=""дд ММММ гггг 'г.' """);
	
	
	АдресОрг = СсылкаДокумент._ИМЦ_Организация.Контрагент.Адрес;
	ПервСим = Найти(АдресОрг," г.");	
	Если  ПервСим  Тогда //или Найти(СсылкаДокумент._ИМЦ_Организация," с.")
		
	    Город = Сред(АдресОрг,ПервСим+3); 
	    Город = Сред(Город,1,Найти(Город,",")-1);
	    ОбластьШапка.Параметры.Город        = "г." + Город;
	Иначе
		
		ПервСим = Найти(АдресОрг,"с.");	
		Если  ПервСим  Тогда //или Найти(СсылкаДокумент._ИМЦ_Организация," с.")
			
			Город = Сред(АдресОрг,ПервСим+3); 
			Город = Сред(Город,1,Найти(Город,",")-1);
			ОбластьШапка.Параметры.Город        = "г." + Город;
		Иначе	
			
			ОбластьШапка.Параметры.Город        = "г. Самара";
		КонецЕсли;	 
	КонецЕсли;	 	
	ОбластьШапка.Параметры.Исполнитель = Объект.ФИОИсполнитель; //филиалах не он
	Если ЗначениеЗаполнено(СсылкаДокумент.Владелец.НаименованиеДляДоговора) Тогда
		мЗаявитель = СсылкаДокумент.Владелец.НаименованиеДляДоговора;
	ИначеЕсли ЗначениеЗаполнено(СсылкаДокумент.Владелец.ПолноеНаименование) Тогда
		мЗаявитель = СсылкаДокумент.Владелец.ПолноеНаименование;
	Иначе 
		мЗаявитель = СсылкаДокумент.Владелец.Наименование;
	КонецЕсли;
	
	ОбластьШапка.Параметры.Заявитель = мЗаявитель;
	ОбластьШапка.Параметры.РуководительЗаказчика = Объект.ФИОРукЗаказчикаРодП;
	ОбластьШапка.Параметры.РуководительЗаказчикаДействуетНаОсновании = Объект.ОснованиеЗаказчика;
	
	Если ЗначениеЗаполнено(Объект.ДолжностьЗаказчика) Тогда 
		ОбластьШапка.Параметры.ДолжностьРуководителяЗаказчика            = _ИМЦ_МодульФайлыПечатьСервер.ПросклонятьБезИспользованияКомпоненты(Объект.ДолжностьЗаказчика, "Родительный", Неопределено, Неопределено, Перечисления._ИМЦ_СклонятьКак.Профессия);
	КонецЕсли; 
	
	Область1.Параметры.ПредметДоговора = СсылкаДокумент.КраткоеСодержание;
	
	Если Объект.Контракт  Тогда        	
		ОбластьШапка.Параметры.ВидОбязательства = "Контракт "; 
		ОбластьШапка.Параметры.ВидОбязательства2 = "контракт "; 
		Область1.Параметры.ВидОбязательства2 = "контракт"; 
		Область2.Параметры.ВидОбязательства2 = "контракт";

		
	Иначе            	
		ОбластьШапка.Параметры.ВидОбязательства = "Договор ";  
		ОбластьШапка.Параметры.ВидОбязательства2 = "договор ";
		Область1.Параметры.ВидОбязательства2 = "договор";
		Область2.Параметры.ВидОбязательства2 = "договор";

	
	КонецЕсли;
	
	Если  Объект.ФЗ223   Тогда
		
		ОбластьШапка.Параметры.ДополненеияФЗ  = "п.5 ст.3 Федерального Закона №223-ФЗ от 18.07.2011г. «О закупках товаров, работ, услуг отдельными видами юридических лиц» ";
		
	ИначеЕсли  Объект.ФЗ44  Тогда     
		
		ОбластьШапка.Параметры.ДополненеияФЗ  = "п.4 ст.93 федерального Закона №44-ФЗ от 05.04.2013г. «О контрактной системе в сфере закупок товаров, работ, услуг для обеспечения муниципальных нужд»";  	
	КонецЕсли;	
	
	
	
	ТабДок.Вывести(ОбластьШапка);
	                                                                         
		
	Если СсылкаДокумент.НаправлениеДеятельности = Справочники._ИМЦ_НаправлениеДеятельности.Основная тогда
		НомерПунктовПрейскуранта = "1";   				
	ИначеЕсли СсылкаДокумент.НаправлениеДеятельности = Справочники._ИМЦ_НаправлениеДеятельности.Иная тогда
		НомерПунктовПрейскуранта = "2";    
	Иначе
		НомерПунктовПрейскуранта = "1,2";   				
	КонецЕсли; 
	
			
	
	Область1.Параметры.Пукт12 = "1.2. Наименование услуг и их стоимость указывается в Расчете стоимости  оказанных услуг и является неотъемлемой частью настоящего договора в виде Приложения №1";  
	
		
	ФормСтрока = "Л = ru_RU; ДП = Истина";
	СуммаПрописью = ЧислоПрописью(СсылкаДокумент.Сумма,ФормСтрока,"рубль, рубля, рублей,  м, копейка, копейки, копеек, ж,2");
	НДСПрописью   = ЧислоПрописью(СсылкаДокумент.НДС,ФормСтрока,"рубль, рубля, рублей,  м, копейка, копейки, копеек, ж,2");
	
	СуммаЧислоСтрокой = Строка(Цел(СсылкаДокумент.Сумма)) +" руб. " + Формат(((СсылкаДокумент.Сумма - Цел(СсылкаДокумент.Сумма)) * 100), "ЧЦ=2; ЧВН=") +" коп.";  				
	НДСЧислоСтрокой   = Строка(Цел(СсылкаДокумент.НДС)) +" руб. " + Формат(((СсылкаДокумент.НДС - Цел(СсылкаДокумент.НДС)) * 100), "ЧЦ=2; ЧВН=") +" коп.";
	

	
	Область31.Параметры.ТекстПункта31 = "3.1. Цена договора составляет " + СуммаЧислоСтрокой +" (" + СуммаПрописью +"), в т.ч. НДС " + НДСЧислоСтрокой + " (" +НДСПрописью +"). Цена по данному договору определяется в соответствии с Приложением № " + НомерПунктовПрейскуранта +"  действующего Прейскуранта цен Исполнителя от 01.01.2015г. " ; 
	
	Область32.Параметры.ТекстПункта32 = "3.2. Оплата осуществляется Заказчиком в форме перечисления денежных средств на расчетный счет Исполнителя в порядке 100% предоплаты от суммы выставленного счета. Моментом оплаты за оказание услуги по настоящему договору считается момент поступления денег на лицевой счет Исполнителя.
	|Исполнитель в течение 5 календарных дней после получения аванса (предоплаты) составляет счет-фактуру на сумму аванса (предоплаты), оформленную в соответствии с п.5.1. ст. 169 Налогового кодекса РФ.";			
	Область33.Параметры.ТекстПункта33 = "3.3. В случае изменения Прейскуранта Исполнитель информирует Заказчика не позднее, чем в десятидневный срок. После внесения 100% предоплаты цена договора изменению не подлежит.";
	
	Область34.Параметры.ТекстПункта34 = "3.4. Несогласие с изменением цены является основанием для приостановки действия договора до согласования цены. Изменение цены оформляется дополнительным соглашением к договору.";
	Область35.Параметры.ТекстПункта35 = "3.5. Заказчик вправе отказаться от исполнения договора возмездного оказания услуг при условии оплаты Исполнителю фактически понесенных им расходов.";
	   
	
	Область4.Параметры.Пункт4 = "4. Порядок сдачи оказанных услуг:";
	Область41.Параметры.ТекстПункта41 = "4.1. При завершении  оказания  услуг оформляется акт оказанных услуг. Исполнитель в течение 5 календарных дней составляет счет-фактуру, оформленную в соответствии с ч.5 ст. 169 НК РФ.";
	Область42.Параметры.ТекстПункта42 = "4.2. Заказчик в течение 5 (пяти) календарных дней со дня получения от Исполнителя акта оказанных услуг обязуется подписать акт оказанных услуг и представить Исполнителю, либо направить Исполнителю мотивированный отказ от подписания акта оказанных услуг.";
	Область43.Параметры.ТекстПункта43 = "4.3. При условии невозвращения Заказчиком в десятидневный срок подписанного акта оказанных услуг или не предоставления мотивированного отказа от подписания акта оказанных услуг, считается, что услуги оказаны Исполнителем надлежащим образом, в полном объеме и приняты Заказчиком без замечаний, а акт оказанных услуг считается подписанным двумя сторонами."; 
	
	Область5.Параметры.Пункт5 = "5. Ответственность сторон:";
	ТекстПункта51 = "5.1. Ответственность Сторон за неисполнение или ненадлежащее исполнение обязательств по договору определяется в соответствии с действующим законодательством Российской Федерации.";
	
	Область51.Параметры.ТекстПункта51    = ТекстПункта51;
	
	Область6.Параметры.Пункт6 = "6. Порядок разрешения споров";
	Область61.Параметры.ТекстПункта61 = "6.1. По спорам, возникающим в процессе исполнения договора, обязателен досудебный порядок урегулирования. Срок ответа на претензию виновной стороны составляет тридцать календарных дней с момента ее передачи органом связи.";
	Область62.Параметры.ТекстПункта62 = "6.2. Все споры и разногласия по настоящему договору, не урегулированные  путем переговоров, рассматриваются в Арбитражном суде Самарской области, в соответствии с действующим законодательством РФ.";
	
	Область7.Параметры.Пункт7 =  "7. Срок договора:";	
	Область71.Параметры.ТекстПункта71 = "7.1. Договор вступает в силу с момента его подписания и действует  до полного исполнения всех обязательств сторонами, по данному договору.";
	Область72.Параметры.ТекстПункта72 = "7.2. Срок оказания услуг по договору – в течение 2 месяцев со дня поступления денег на лицевой счёт Исполнителя";
	          	
	Область8.Параметры.Пункт8 =  "8. Форс-мажорные обстоятельства:";
	Область81.Параметры.ТекстПункта81 = "8.1. Стороны освобождаются  от ответственности за частичное или полное неисполнение обязательств по настоящему договору, если они оказались невозможными вследствие непреодолимой силы, то есть чрезвычайных и непредотвратимых, при данных условиях, обстоятельствах (военных действий, пожара, землетрясения, наводнения, правительственных постановлений и пр.).";
	Область82.Параметры.ТекстПункта82 = "8.2. Сторона, для которой создалась невозможность исполнения обязательств, обязана в пятидневный срок известить об этом другую сторону в письменном виде с приложением подтверждающих документов.";
	Область83.Параметры.ТекстПункта83 = "8.3. На период действия форс-мажорных обстоятельств увеличиваются сроки исполнения обязательств по договору.";
	Область84.Параметры.ТекстПункта84 = "8.4. Если форс-мажорные обстоятельства длятся более трех месяцев, каждая из Сторон вправе отказаться от исполнения договора без права требовать возмещения убытков.";
	
	Область9.Параметры.Пункт9   =  "9. Условия конфиденциальности:";
	Область91.Параметры.ТекстПункта91 = "9.1. Условия договора являются конфиденциальными и Стороны обязуются не разглашать его условия как в течение срока действия договора, так и в последующие 3 (три) года с момента прекращения его действия, за исключением разглашения его условий по обоснованным и законным требованиям лиц, указанных в п. 9.3 настоящего договора.";
	Область92.Параметры.ТекстПункта92 = "9.2. Если иное не будет установлено соглашением Сторон, то конфиденциальными являются все получаемые Исполнителем и Заказчиком друг от друга в процессе исполнения договора сведения за исключением тех, которые без участия этих Сторон были или будут опубликованы или распространены в иной форме в официальных (служебных) источниках, либо стали или станут известны от третьих лиц без участия Сторон.
	|Исполнитель не должен без предварительного письменного согласия Заказчика использовать какие-либо конфиденциальные сведения, кроме как в целях реализации договора.";
	Область93.Параметры.ТекстПункта93 = "9.3. Не считается разглашением условий договора сообщение части его условий налоговым органам, а также иным органам обязанность предоставления информации которым, предусмотрена в соответствии с действующим законодательством.";
	
	Область10.Параметры.Пункт10 =  "10. Особые условия:";	
	Область101.Параметры.ТекстПункта101 = "10.1. Все изменения и дополнения к настоящему договору вносятся в письменной форме.";
	Область102.Параметры.ТекстПункта102 = "10.2. Все приложения к настоящему договору являются его неотъемлемой частью.";
	Область103.Параметры.ТекстПункта103 = "10.3. Условия настоящего договора могут быть дополнены и изменены по взаимному соглашению Сторон, если они составлены в письменной форме и подписаны уполномоченными на то представителями обеих Сторон.";
	Область104.Параметры.ТекстПункта104 = "10.4. Действие настоящего договора прерывается на срок проведения проверки Заказчика  Управлением Роспотребнадзора по Самарской области (плановой, внеплановой). Период прерывания действия договора определяется датами проведения проверки, указанными в распоряжении руководителя Управления Роспотребнадзора по Самарской области (территориального отдела). Действие договора прерывается автоматически, подписания дополнительного соглашения не требуется. Действие договора возобновляется на следующий день после даты завершения проверки. Датой завершения проверки считается дата оформления акта проверки в окончательной форме.";
	Область105.Параметры.ТекстПункта105 = "10.5. Настоящий договор составлен в двух экземплярах, по одному для каждой Стороны, имеющих одинаковую юридическую силу.";
	
	Область11.Параметры.Пункт11 =  "11. Реквизиты и местонахождение Сторон:";

		
		
						 #Область вывод_областей
	
		ТабДок.Вывести(Область1);
		ТабДок.Вывести(Область2);
		ТабДок.Вывести(Область3);
		ТабДок.Вывести(Область31);   
		ТабДок.Вывести(Область32);   
		ТабДок.Вывести(Область33);   
		ТабДок.Вывести(Область34);   
		ТабДок.Вывести(Область35);
		ТабДок.Вывести(Область4);  
		ТабДок.Вывести(Область41); 
		ТабДок.Вывести(Область42);
		ТабДок.Вывести(Область43);
		ТабДок.Вывести(Область5); 
		ТабДок.Вывести(Область51);
		Если ЗначениеЗаполнено(Область52.Параметры.ТекстПункта52) Тогда 
			ТабДок.Вывести(Область52);
		КонецЕсли;	
		ТабДок.Вывести(Область6);
		ТабДок.Вывести(Область61);   
		ТабДок.Вывести(Область62); 
		ТабДок.Вывести(Область7);
		ТабДок.Вывести(Область71);
		ТабДок.Вывести(Область72);
		ТабДок.Вывести(Область8);
		ТабДок.Вывести(Область81);
		ТабДок.Вывести(Область82);
		ТабДок.Вывести(Область83);
		ТабДок.Вывести(Область84);
		ТабДок.Вывести(Область9);
		ТабДок.Вывести(Область91);
		ТабДок.Вывести(Область92);
		ТабДок.Вывести(Область93);
		//ТабДок.Вывести(Область94);
		//ТабДок.Вывести(Область95);
		ТабДок.Вывести(Область10);
		ТабДок.Вывести(Область101);
		ТабДок.Вывести(Область102);
		ТабДок.Вывести(Область103);
		ТабДок.Вывести(Область104);
		ТабДок.Вывести(Область105);
		ТабДок.Вывести(Область11);
		
		#КонецОбласти
		
	
	
	
	#Область Реквизиты_Заказчика_И_Исполнителя 
	
	//данные исполнителя
	//======================================================================================================================
	
	Если ЗначениеЗаполнено(СсылкаДокумент.Ответственный.Подразделение) Тогда
		
		ОбластьРеквизиты.Параметры.ДанныеИсполнителя =СсылкаДокумент.Ответственный.Подразделение.ДанныеДляДоговора;
		
	ИначеЕсли ЗначениеЗаполнено(СсылкаДокумент.Ответственный.Лаборатория.Владелец) Тогда
		
		ОбластьРеквизиты.Параметры.ДанныеИсполнителя =СсылкаДокумент.Ответственный.Лаборатория.Владелец.ДанныеДляДоговора;
		
	КонецЕсли;	
	
	ОбластьРеквизиты.Параметры.ПодписьИсполнителя = СтрЗаменить(Объект.ИсполнительПодписывающий,"^p",Символы.ПС);
	
    //данные заказичика
	//======================================================================================================================
	Если Найти(СсылкаДокумент.ВидДоговора.Наименование,"с частными лицами") Тогда //СсылкаДокумент.Владелец.ВидКонтрагента = Перечисления._ИМЦ_ВидыКонтрагентов.ФизЛицо Тогда
		ДанныеЗаявителя = "";
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.Наименование),"Гр-н(ка) "+СсылкаДокумент.Владелец,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.ПаспортНомер),ДанныеЗаявителя + "
		|" +"Паспорт "+СсылкаДокумент.Владелец.ПаспортНомер + СсылкаДокумент.Владелец.ПаспортСерия,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.ПаспортВыдан),ДанныеЗаявителя + "
		|" +"Выдан "+СсылкаДокумент.Владелец.ПаспортВыдан,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.АдресПочтовый),ДанныеЗаявителя + "
		|" +"Адрес проживания "+СсылкаДокумент.Владелец.АдресПочтовый,ДанныеЗаявителя);  
		
		ОбластьРеквизиты.Параметры.ПодписьЗаказчика = "Подпись ____________"; 
		
		
	Иначе
		
		Если ЗначениеЗаполнено(СсылкаДокумент.Владелец.НаименованиеДляДоговора) Тогда
			ДанныеЗаявителя =СсылкаДокумент.Владелец.НаименованиеДляДоговора;
		ИначеЕсли ЗначениеЗаполнено(СсылкаДокумент.Владелец.ПолноеНаименование) Тогда
			ДанныеЗаявителя =СсылкаДокумент.Владелец.ПолноеНаименование;
		Иначе 
			ДанныеЗаявителя =СсылкаДокумент.Владелец.Наименование;
		КонецЕсли;     	
		
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.Адрес),ДанныеЗаявителя + "
		|" +"Юр. адрес "+СсылкаДокумент.Владелец.Адрес,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.АдресПочтовый),ДанныеЗаявителя + "
		|" +"Почт. адрес " +СсылкаДокумент.Владелец.АдресПочтовый,ДанныеЗаявителя);   	                        	
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.ИНН),ДанныеЗаявителя + "
		|" + "ИНН " +СсылкаДокумент.Владелец.ИНН,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.КПП),ДанныеЗаявителя + "
		|" + "КПП " +СсылкаДокумент.Владелец.КПП,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.ОГРН),ДанныеЗаявителя + "
		|" + "ОГРН " +СсылкаДокумент.Владелец.ОГРН,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.ОКПО),ДанныеЗаявителя + "
		|" + "ОКПО " +СсылкаДокумент.Владелец.ОКПО,ДанныеЗаявителя);         		
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.ОКАТО),ДанныеЗаявителя + "
		|" + "ОКАТО " +СсылкаДокумент.Владелец.ОКАТО,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.РасчетныйСчет),ДанныеЗаявителя + "
		|" + "р/с" +СсылкаДокумент.Владелец.РасчетныйСчет,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.КорреспонденскийСчет),ДанныеЗаявителя + "
		|" + "к/с " +СсылкаДокумент.Владелец.КорреспонденскийСчет,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.БИК),ДанныеЗаявителя + "
		|" + "БИК" +СсылкаДокумент.Владелец.БИК,ДанныеЗаявителя);
		
		ДанныеЗаявителя = ?( ЗначениеЗаполнено(СсылкаДокумент.Владелец.БИК),ДанныеЗаявителя + "
		|" + "Банк " +СсылкаДокумент.Владелец.Банк,ДанныеЗаявителя);
		
		ОбластьРеквизиты.Параметры.ПодписьЗаказчика = Объект.ДолжностьЗаказчика + 	"
		|" +"____________  " + Объект.ФИОРукЗаказчикаИмПад; 
		
		
	КонецЕсли;
	
	ОбластьРеквизиты.Параметры.ДанныеЗаказчика = ДанныеЗаявителя ;  	
	
	#КонецОбласти

	
	ОбластьРеквизиты.Параметры.Примечание = СсылкаДокумент.Ответственный.Примечание;
	
	
	ТабДок.Вывести(ОбластьРеквизиты); 	
	
	
	
	Возврат ТабДок;
КонецФункции	

&НаСервереБезКонтекста
Функция ПроверкаСуществованияИмени(ИмяВрем)
	
	СсылкаНаФайл = Справочники.Файлы.НайтиПоНаименованию(ИмяВрем);
	Если СсылкаНаФайл = Справочники.Файлы.ПустаяСсылка() Тогда
		Возврат Истина; 
	Иначе
		Возврат Ложь;		
	КонецЕсли;
	
	
КонецФункции

&НаСервере
Функция НайдемНашФайл(ИмяФайла)	Экспорт
	Возврат Справочники.Файлы.НайтиПоНаименованию(ИмяФайла);
КонецФункции	

&НаКлиенте
Процедура ВопросОРедактированииФайлаЗавершение(ОтветНаВопрос, ДополнительныеПараметры) Экспорт
	
	Если ОтветНаВопрос = "На редактирование" Тогда
		РаботаСФайламиСлужебныйКлиент.РедактироватьФайлПоСсылке(,ДополнительныеПараметры.ФайлСсылка,ЭтаФорма.УникальныйИдентификатор,);  
	Иначе
			
		ДанныеФайла = РаботаСФайламиСлужебныйВызовСервера.ДанныеФайлаДляОткрытия(ДополнительныеПараметры.ФайлСсылка,
			ЭтаФорма.УникальныйИдентификатор, Неопределено, Неопределено);
			РаботаСФайламиКлиент.Открыть(ДанныеФайла);
		
	КонецЕсли; 
	
КонецПроцедуры




