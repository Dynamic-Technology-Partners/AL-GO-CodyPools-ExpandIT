
/// <summary>
/// Codeunit "ExpandITAPI" (ID 68762).
/// </summary>
codeunit 68762 ExpandITAPI
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    /// <summary>
    /// CheckConnection.
    /// </summary>
    /// <returns>Return variable Res of type Boolean.</returns>
    procedure CheckConnection() Res: Boolean
    begin
        Res := True;
    end;

    /// <summary>
    /// GetFeatures.
    /// </summary>
    /// <param name="VAR OutData">Text.</param>
    /// <returns>Return variable Res of type Boolean.</returns>
    procedure GetFeatures(VAR OutData: Text) Res: Boolean
    var
        xmlDoc: XmlDocument;
        xmlDec: XmlDeclaration;
        xmlElem: XmlElement;
        xmlElem2: XmlElement;
    begin
        xmlDoc := XmlDocument.Create();
        xmlDec := XmlDeclaration.Create('1.0', 'UTF-8', 'yes');
        xmlDoc.SetDeclaration(xmlDec);

        xmlElem := XmlElement.Create('Root');

        xmlElem2 := XmlElement.Create('Feature');
        xmlElem2.SetAttribute('Added', '2020-10-01');
        xmlElem2.Add(xmlText.Create('SkippedTables'));
        xmlElem.Add(xmlElem2);

        xmlElem2 := XmlElement.Create('Feature');
        xmlElem2.SetAttribute('Added', '2020-10-01');
        xmlElem2.Add(xmlText.Create('TimeStamp'));
        xmlElem.Add(xmlElem2);

        xmlDoc.Add(xmlElem);

        xmlDoc.WriteTo(OutData);

        Res := True;
    end;

    /// <summary>
    /// GetSchema.
    /// </summary>
    /// <param name="VAR OutData">Text.</param>
    /// <returns>Return variable Res of type Boolean.</returns>
    procedure GetSchema(VAR OutData: Text) Res: Boolean
    begin
        Res := GetSchemaEx(false, OutData);
    end;

    /// <summary>
    /// GetSchemaWithSkipped.
    /// </summary>
    /// <param name="VAR OutData">Text.</param>
    /// <returns>Return variable Res of type Boolean.</returns>
    procedure GetSchemaWithSkipped(VAR OutData: Text) Res: Boolean
    begin
        Res := GetSchemaEx(true, OutData);
    end;

    local procedure GetSchemaEx(IncludeSkipped: Boolean; VAR OutData: Text) Res: Boolean
    var
        TMetadata: Record "Table Metadata";
        xmlDoc: XmlDocument;
        xmlDec: XmlDeclaration;
        xmlElem: XmlElement;
        xmlElem2: XmlElement;
        xmlElem3: XmlElement;
        XmlAttr: XmlAttribute;
        i: Integer;
    begin
        TMetadata.SetRange(TableType, TMetadata.TableType::Normal);
        TMetadata.FindFirst();

        xmlDoc := XmlDocument.Create();
        xmlDec := XmlDeclaration.Create('1.0', 'UTF-8', 'yes');
        xmlDoc.SetDeclaration(xmlDec);

        xmlElem := XmlElement.Create('Root');

        repeat
            if (TMetadata.ObsoleteState <> TMetadata.ObsoleteState::Removed) then begin
                if TryGetTable(TMetadata.ID, TMetadata.Name, xmlElem2) then
                    xmlElem.Add(xmlElem2)
                else begin
                    if (IncludeSkipped) then begin
                        xmlElem2 := XmlElement.Create('Table');
                        xmlElem2.SetAttribute('Id', format(TMetadata.ID));
                        xmlElem2.SetAttribute('Name', Format(TMetadata.Name));
                        xmlElem2.SetAttribute('Skipped', '1');
                        xmlElem2.SetAttribute('Reason', GETLASTERRORTEXT);
                        xmlElem.Add(xmlElem2);
                    end;
                end;
            end;

        until TMetadata.Next = 0;

        xmlDoc.Add(xmlElem);

        xmlDoc.WriteTo(OutData);

        Res := True;
    end;

    [TryFunction]
    local procedure TryGetTable(TableNo: Integer; TableName: Text; VAR xmlElem2: XmlElement)
    var
        RR: RecordRef;
        FieldTable: Record "Field";
        xmlElem3: XmlElement;
    begin
        xmlElem2 := XmlElement.Create('Table');
        xmlElem2.SetAttribute('Id', format(TableNo));
        xmlElem2.SetAttribute('Name', Format(TableName));
        RR.Open(TableNo);
        xmlElem2.SetAttribute('Key', Format(RR.CurrentKey()));
        FieldTable.SetRange(TableNo, TableNo);
        FieldTable.FindFirst();
        repeat
            if (FieldTable.ObsoleteState <> FieldTable.ObsoleteState::Removed) then begin
                xmlElem3 := XmlElement.Create('Field');
                xmlElem3.SetAttribute('No', Format(FieldTable."No."));
                xmlElem3.SetAttribute('Name', Format(FieldTable.FieldName));
                xmlElem3.SetAttribute('Type', Format(FieldTable.Type));
                xmlElem3.SetAttribute('Length', Format(FieldTable.Len));
                xmlElem3.SetAttribute('Class', Format(FieldTable.Class));
                xmlElem2.Add(xmlElem3);
            end;
        until FieldTable.Next = 0;

        RR.Close();

    end;

    /// <summary>
    /// Get.
    /// </summary>
    /// <param name="strRequest">Text.</param>
    /// <param name="VAR strResponse">Text.</param>
    /// <returns>Return variable Res of type Boolean.</returns>
    procedure Get(strRequest: Text; VAR strResponse: Text) Res: Boolean
    var
        RR: RecordRef;
        FR: FieldRef;
        lstFields: List of [Text];
        strField: Text;
        intField: Integer;
        xmlDocRequest: XmlDocument;
        xmlOptions: XmlReadOptions;
        xmlFilter: XmlNode;
        xmlFilters: XmlNodeList;
        xmlFields: XmlNodeList;
        xmlField: xmlNode;
        xmlDoc: XmlDocument;
        xmlDec: XmlDeclaration;
        xmlElem: XmlElement;
        xmlElem1: XmlElement;
        xmlElem2: XmlElement;
        xmlElem3: XmlElement;
        xmlAttr: XmlAttribute;
        xmlAttrs: XmlAttributeCollection;
        xmlNode: XmlNode;

        //valueBlob: record TempBlob;
        valueBlob: Codeunit "Temp Blob";
        base64: Codeunit "Base64 Convert";
        outStream: OutStream;
        inStream: InStream;

        Test: Text;
        TableNo: Integer;
        RowCount: Integer;
        MoreRows: Integer;
        MaxRows: Integer;
        SkipRows: Integer;
    begin
        RowCount := 0;

        xmlOptions.PreserveWhitespace := true;

        XmlDocument.ReadFrom(strRequest, xmlOptions, xmlDocRequest);

        if xmlDocRequest.SelectSingleNode('/DataRequest/Table', xmlNode) then
            Evaluate(TableNo, xmlNode.AsXmlElement().InnerText())
        else
            ERROR('Table node not found');

        if xmlDocRequest.SelectSingleNode('/DataRequest/MaxRows', xmlNode) then
            Evaluate(MaxRows, xmlNode.AsXmlElement().InnerText())
        else
            MaxRows := 0;

        if xmlDocRequest.SelectSingleNode('/DataRequest/SkipRows', xmlNode) then
            Evaluate(SkipRows, xmlNode.AsXmlElement().InnerText())
        else
            SkipRows := 0;

        RR.Open(TableNo);

        if xmlDocRequest.SelectNodes('/DataRequest/Filters/Filter', xmlFilters) then begin
            foreach xmlFilter in xmlFilters do begin
                xmlAttrs := xmlFilter.AsXmlElement().Attributes();
                foreach xmlAttr in xmlAttrs do begin
                    if xmlAttr.Name = 'Field' then begin
                        Evaluate(intField, xmlAttr.Value());
                        FR := RR.Field(intField);
                    end;
                end;
                FR.SetFilter(xmlFilter.AsXmlElement().InnerText());
            end;
        end;

        xmlDoc := XmlDocument.Create();
        xmlDec := XmlDeclaration.Create('1.0', 'UTF-8', 'yes');
        xmlDoc.SetDeclaration(xmlDec);

        xmlElem := XmlElement.Create('DataResponse');
        xmlElem1 := XmlElement.Create('DataRows');
        xmlElem1.SetAttribute('TableName', Format(TableNo));
        if RR.Find('-') then begin
            If RR.Next(SkipRows) = SkipRows then begin
                repeat
                    xmlElem2 := XmlElement.Create('Record');
                    xmlElem2.SetAttribute('name', Format(TableNo));
                    if xmlDocRequest.SelectNodes('/DataRequest/Fields/Field', xmlFields) then begin
                        foreach xmlField in xmlFields do begin
                            xmlElem3 := XmlElement.Create('Field');
                            intField := 0;
                            xmlAttrs := xmlField.AsXmlElement().Attributes();
                            foreach xmlAttr in xmlAttrs do begin
                                if xmlAttr.Name = 'name' then begin
                                    if not Evaluate(intField, xmlAttr.Value()) then
                                        ERROR('Field missing name attribute');
                                end;
                            end;
                            xmlElem3.SetAttribute('name', Format(intField));
                            IF FORMAT(RR.Field(intField).Type()) = 'BLOB' THEN BEGIN
                                RR.Field(intField).CalcField();
                                FR := RR.Field(intField);
                                // valueBlob.Init();
                                // valueBlob.Blob := FR.Value();
                                // xmlElem3.Add(xmlText.Create(Format(valueBlob.ToBase64String(), 0, 9)));

                                valueBlob.CreateInStream(inStream);
                                valueBlob.FromFieldRef(FR);
                                xmlElem3.Add(xmlText.Create(Format(base64.ToBase64(inStream))));
                            END
                            ELSE BEGIN
                                IF FORMAT(RR.Field(intField).CLASS) = 'FlowField' THEN
                                    RR.Field(intField).CalcField();

                                xmlElem3.Add(xmlText.Create(Format(RR.Field(intField), 0, 9)));
                            END;

                            xmlElem2.Add(xmlElem3);
                        end;
                    end;

                    xmlElem1.Add(xmlElem2);
                    RowCount := RowCount + 1;
                    MoreRows := RR.Next();
                until (MoreRows = 0) OR ((RowCount >= MaxRows) AND (MaxRows > 0));
            end;
        end;

        xmlElem.Add(xmlElem1);
        xmlElem1 := XmlElement.Create('RowCount');
        xmlElem1.Add(xmlText.Create(Format(RowCount, 0, 9)));
        xmlElem.Add(xmlElem1);
        xmlElem1 := XmlElement.Create('MoreRows');
        xmlElem1.Add(xmlText.Create(Format(MoreRows, 0, 9)));
        xmlElem.Add(xmlElem1);
        xmlDoc.Add(xmlElem);

        RR.Close;

        xmlDoc.WriteTo(strResponse);

        Res := TRUE;
    end;

    /// <summary>
    /// Set.
    /// </summary>
    /// <param name="strRequest">Text.</param>
    /// <returns>Return variable Res of type Text.</returns>
    procedure Set(strRequest: Text) Res: Text
    var
        RR: RecordRef;
        FR: FieldRef;
        xmlDocRequest: XmlDocument;
        xmlOptions: XmlReadOptions;
        TableNo: Integer;
        KeyField: Integer;
        xmlNode: XmlNode;
        xmlRecords: XmlNodeList;
        xmlRecord: XmlNode;
        KeyValue: Text;
        NewRecord: Boolean;
        xmlFields: XmlNodeList;
        xmlField: xmlNode;
        xmlAttr: XmlAttribute;
        xmlAttrs: XmlAttributeCollection;
        intField: Integer;
        NewCount: Integer;
        UpdateCount: Integer;
        valueDate: Date;
        valueDateTime: DateTime;
        valueTime: Time;
        valueBoolean: Boolean;
        valueDecimal: Decimal;
        //valueBlob: record TempBlob;
        valueBlob: Codeunit "Temp Blob";
        base64: Codeunit "Base64 Convert";
        outStream: OutStream;
        inStream: InStream;
        blobText: Text;

    begin
        NewCount := 0;
        UpdateCount := 0;

        xmlOptions.PreserveWhitespace := true;

        XmlDocument.ReadFrom(strRequest, xmlOptions, xmlDocRequest);

        if xmlDocRequest.SelectSingleNode('/DataRequest/Table', xmlNode) then
            Evaluate(TableNo, xmlNode.AsXmlElement().InnerText())
        else
            ERROR('Table node not found');

        if xmlDocRequest.SelectSingleNode('/DataRequest/KeyField', xmlNode) then
            Evaluate(KeyField, xmlNode.AsXmlElement().InnerText())
        else
            ERROR('KeyField node not found');

        RR.Open(TableNo);

        if xmlDocRequest.SelectNodes('/DataRequest/DataRows/Record', xmlRecords) then begin
            foreach xmlRecord in xmlRecords do begin
                NewRecord := false;
                // Find KeyValue
                if xmlRecord.SelectSingleNode('Field[@name="' + format(KeyField) + '"]', xmlNode) then
                    KeyValue := xmlNode.AsXmlElement().InnerText()
                else
                    ERROR('No value for KeyField');

                FR := RR.Field(KeyField);
                FR.Value := KeyValue;

                if not RR.Find('=') then begin
                    RR.Init();
                    RR.Field(KeyField).Value(KeyValue);
                    NewRecord := true;
                end;

                // Set values
                if xmlRecord.SelectNodes('Field', xmlFields) then begin
                    foreach xmlField in xmlFields do begin
                        // Find name
                        intField := 0;
                        xmlAttrs := xmlField.AsXmlElement().Attributes();
                        foreach xmlAttr in xmlAttrs do begin
                            if xmlAttr.Name = 'name' then begin
                                Evaluate(intField, xmlAttr.Value());
                            end;
                        end;
                        if intField = 0 then
                            ERROR('Field missing name attribute');
                        if intField <> KeyField then begin
                            CASE FORMAT(RR.Field(intField).Type()) OF
                                'DateTime':
                                    BEGIN
                                        Evaluate(valueDateTime, xmlField.AsXmlElement().InnerText(), 9);
                                        RR.Field(intField).Value(valueDateTime);
                                    END;
                                'Date':
                                    BEGIN
                                        Evaluate(valueDateTime, xmlField.AsXmlElement().InnerText(), 9);
                                        valueDate := DT2Date(valueDateTime);
                                        RR.Field(intField).Value(valueDate);
                                    END;
                                'Time':
                                    BEGIN
                                        Evaluate(valueDateTime, xmlField.AsXmlElement().InnerText(), 9);
                                        valueTime := DT2Time(valueDateTime);
                                        RR.Field(intField).Value(valueTime);
                                    END;
                                'Boolean':
                                    BEGIN
                                        Evaluate(valueBoolean, xmlField.AsXmlElement().InnerText(), 9);
                                        RR.Field(intField).Value(valueBoolean);
                                    END;
                                'Decimal':
                                    BEGIN
                                        Evaluate(valueDecimal, xmlField.AsXmlElement().InnerText(), 9);
                                        RR.Field(intField).Value(valueDecimal);
                                    END;
                                'BLOB':
                                    BEGIN
                                        // valueBlob.Init();
                                        // valueBlob.FromBase64String(xmlField.AsXmlElement().InnerText());
                                        // FR := RR.Field(intField);
                                        // FR.Value(valueBlob.Blob); 

                                        valueBlob.CreateOutStream(outStream);
                                        FR := RR.Field(intField);
                                        base64.FromBase64(xmlField.AsXmlElement().InnerText(), outStream);
                                        valueBlob.ToFieldRef(FR);
                                    END;
                                'Integer':
                                    BEGIN
                                        IF xmlField.AsXmlElement().InnerText() = '' THEN
                                            RR.Field(intField).Value(0)
                                        ELSE
                                            RR.Field(intField).Value(xmlField.AsXmlElement().InnerText());
                                    END;
                                ELSE BEGIN
                                    RR.Field(intField).Value(xmlField.AsXmlElement().InnerText());
                                END;
                            END
                        end;
                    end;
                end;

                // Commit
                if NewRecord then begin
                    NewCount := NewCount + 1;
                    RR.Insert()
                end
                else begin
                    UpdateCount := UpdateCount + 1;
                    RR.Modify();
                end;
            end;
        end;

        Res := Format(NewCount) + ',' + Format(UpdateCount);
    end;
}

