
&AtClient
Procedure Command1(Command)
	Command1AtServer();
EndProcedure

&AtServer
Procedure Command1AtServer()     
    inText = "Клиент 1234"     ;
	KeyClient = GetClient(inText);
	Сообщить("Сегодня "+inText);   	// Insert handler content.
EndProcedure

// Получить ИД клиента 
// Returns:
// Boolean - True if at least one of the passed roles is available to the current user or the
Function GetClient(text)      
	RegExpExecute();
	result= ПроверитьСтроку(text,"Клиент");
		 
		                                               
    Сообщить(ПроверитьСтроку("2012a","\d{4}."));
EndFunction               


Функция ПроверитьСтроку(Строка, Фасет)
    Чтение = Новый ЧтениеXML;
    Чтение.УстановитьСтроку(
                "<Model xmlns=""http://v8.1c.ru/8.1/xdto"" xmlns:xs=""http://www.w3.org/2001/XMLSchema"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xsi:type=""Model"">
                |<package targetNamespace=""sample-my-package"">
                |<valueType name=""testtypes"" base=""xs:string"">
                |<pattern>" + Фасет + "</pattern>
                |</valueType>
                |<objectType name=""TestObj"">
                |<property xmlns:d4p1=""sample-my-package"" name=""TestItem"" type=""d4p1:testtypes""/>
                |</objectType>
                |</package>
                |</Model>");

    Модель = ФабрикаXDTO.ПрочитатьXML(Чтение);
    МояФабрикаXDTO = Новый ФабрикаXDTO(Модель);
    Пакет = МояФабрикаXDTO.Пакеты.Получить("sample-my-package");
    Тест = МояФабрикаXDTO.Создать(Пакет.Получить("TestObj"));

    Попытка
        Тест.TestItem = Строка;   
		
        Возврат Строка
    Исключение
        Возврат ""
    КонецПопытки;
    
КонецФункции   

Процедура RegExpExecute()
 RegExp = Новый COMОбъект("VBScript.RegExp");
 
 RegExp.IgnoreCase = Ложь;
 RegExp.Global = Истина;
 RegExp.MultiLine = Ложь;
 
 RegExp.Pattern = "<[^>]*>*";
 Matches=RegExp.Execute("<asdsad>Тестовая   строка  с HTML тегами");
 
 Для С = 0 По Matches.Count()-1 Цикл
 Match = Matches.Item(С);
 Сообщить(Match.Value);
 КонецЦикла;
КонецПроцедуры