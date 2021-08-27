<!-- default badges list -->
![](https://img.shields.io/endpoint?url=https://codecentral.devexpress.com/api/v1/VersionRange/128547145/13.1.4%2B)
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/E4157)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
<!-- default badges end -->
<!-- default file list -->
*Files to look at*:

* [CustomEvents.cs](./CS/WebSite/App_Code/CustomEvents.cs) (VB: [CustomEvents.vb](./VB/WebSite/App_Code/CustomEvents.vb))
* [Helpers.cs](./CS/WebSite/App_Code/Helpers.cs) (VB: [Helpers.vb](./VB/WebSite/App_Code/Helpers.vb))
* [UserAppointmentFormClass.cs](./CS/WebSite/App_Code/UserAppointmentFormClass.cs) (VB: [UserAppointmentFormClass.vb](./VB/WebSite/App_Code/UserAppointmentFormClass.vb))
* [Default.aspx](./CS/WebSite/Default.aspx) (VB: [Default.aspx](./VB/WebSite/Default.aspx))
* [Default.aspx.cs](./CS/WebSite/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/WebSite/Default.aspx.vb))
* [UserAppointmentForm.ascx](./CS/WebSite/MyForms/UserAppointmentForm.ascx) (VB: [UserAppointmentForm.ascx](./VB/WebSite/MyForms/UserAppointmentForm.ascx))
* [UserAppointmentForm.ascx.cs](./CS/WebSite/MyForms/UserAppointmentForm.ascx.cs) (VB: [UserAppointmentForm.ascx.vb](./VB/WebSite/MyForms/UserAppointmentForm.ascx.vb))
<!-- default file list end -->
# How to implement complex validation in a custom appointment form


<p>This example illustrates how to implement complex validation in a custom appointment form.</p><p>The simplest validation logic is applied to a <strong>tbSubject </strong>text box. It has one <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxEditorsValidationSettings_RequiredFieldtopic"><u>RequiredField</u></a> rule:<br />
</p>

```aspx
<dxe:ASPxTextBox ClientInstanceName="tbSubject" ID="tbSubject" runat="server" Width="100%" Text='<%# ((UserAppointmentFormTemplateContainer)Container).Appointment.Subject %>' >
    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ValidationGroup="CustomAppointmentForm">
        <RequiredField ErrorText="The Subject must contain at least one character." IsRequired="True" />
    </ValidationSettings>
    <ClientSideEvents ValueChanged="function(s, e) { OnUpdateControlValue(s, e); }" />
</dxe:ASPxTextBox>

```

<p>Much more complex logic is applied to a <strong>tbPrice </strong>text box with a custom field value:<br />
</p>

```aspx
<dxe:ASPxTextBox ID="tbPrice" runat="server" ClientInstanceName="tbPrice" Width="100%" Text='<%# ((UserAppointmentFormTemplateContainer)Container).Field1 %>' BackColor="Ivory">
    <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ValidationGroup="CustomAppointmentForm">
        <RegularExpression ErrorText="Enter the Price value as a positive decimal." ValidationExpression="(^(\d*)\.(\d*)$)|(^\d*$)" />
        <RequiredField ErrorText="The Price cannot be blank." IsRequired="True" />
    </ValidationSettings>
    <ClientSideEvents ValueChanged="function(s, e) { OnUpdateControlValue(s, e); }" Validation="function(s, e) { OnPriceValidate(s, e); }" KeyDown="function(s, e) { validatedOnServer = false; }" />
</dxe:ASPxTextBox>

```

<p>It has the <strong>RequiredField </strong>and <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxEditorsValidationSettings_RegularExpressiontopic"><u>RegularExpression</u></a> rules. Moreover, please note that validation of this control is continued in the <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxEditorsScriptsASPxClientEdit_Validationtopic"><u>ASPxClientEdit.Validation Event</u></a> handler, even if initial validation according to these rules is passed. This event handler is defined as follows:<br />
</p>

```js
    function OnPriceValidate(s, e) {
        if(e.isValid && !validatedOnServer) {
            var value = parseFloat(e.value);
            e.isValid = false;
            e.errorText = "Server-side validation...";
            cbValidation.PerformCallback(e.value.toString());
        }
    }

```

<p>Here, we check if the client-side validation is passed. Then we launch server-side validation, which is implemented based on the <a href="http://documentation.devexpress.com/#AspNet/clsDevExpressWebASPxCallbackASPxCallbacktopic"><u>ASPxCallback Class</u></a> component. Here is server-side validation logic in the <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxCallbackASPxCallback_Callbacktopic"><u>ASPxCallback.Callback Event</u></a> handler:<br />
</p>

```cs
    protected void cbValidation_Callback(object source, CallbackEventArgs e) {
        int price = Convert.ToInt32(e.Parameter);

        // Custom validation rule.
        // You can use ((AppointmentFormTemplateContainer)Parent).Control.Storage.Appointments
        // collection here to access attributes of other appointments.
        if (price == 10 || price == 20)
            e.Result = "valid";
        else
            e.Result = "Price must be 10 or 20.";
    }

```

<p>We intercept the result in the client-side <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxCallbackScriptsASPxClientCallback_CallbackCompletetopic"><u>ASPxClientCallback.CallbackComplete Event</u></a> handler as follows:<br />
</p>

```js
    function(s, e) { 
        validatedOnServer = true;
        if (e.result == 'valid') {
            tbPrice.SetIsValid(true); 
        }
        else {
            tbPrice.SetIsValid(false); 
            tbPrice.SetErrorText(e.result);
        }
        OnUpdateControlValue(s, e); 
    }

```

<p>The <strong>OnUpdateControlValue()</strong> method is used to switch the availability of an OK button:<br />
</p>

```js
    function OnUpdateControlValue(s, e) {
        btnOk.SetEnabled(tbSubject.GetIsValid() && tbPrice.GetIsValid());
    }

```

<p>You can display any additional information to the end-user in this method. However, it seems to be unnecessary because the corresponding validation errors are already indicated according to the <a href="http://documentation.devexpress.com/#AspNet/DevExpressWebASPxEditorsErrorDisplayModeEnumtopic"><u>ErrorDisplayMode</u></a> specified for both text boxes.</p><p>Finally, even if all these strict validation tests are passed, you cannot simply press the OK button because we add one last custom-made validation check in the overridden <strong>AppointmentForm.DataBind()</strong> method:<br />
</p>

```cs
    btnOk.ClientSideEvents.Click = string.Format("function() {{ if (confirm('Apply changes?')) aspxAppointmentSave('{0}'); }}", container.Control.ClientID);

```

<p>This is a final conformation to commit changes. Note that the same approach is used in the <a href="https://www.devexpress.com/Support/Center/p/E3999">End-User Restrictions - How to implement a client-side confirmation on deleting an appointment</a> code example.</p><p><strong>See Also:</strong><br />
<a href="http://demos.devexpress.com/ASPxSchedulerDemos/Customization/CustomAppointmentForm.aspx"><u>Customization - Custom Appointment Form</u></a></p>

<br/>


