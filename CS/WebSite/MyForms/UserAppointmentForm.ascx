<%@ Control Language="C#" AutoEventWireup="true" Inherits="AppointmentForm" CodeFile="UserAppointmentForm.ascx.cs" %>
<%@ Register Assembly="DevExpress.Web.v11.1, Version=11.1.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxCallback" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1, Version=11.1.12.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxEditors.v11.1" Namespace="DevExpress.Web.ASPxEditors" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v11.1" Namespace="DevExpress.Web.ASPxScheduler.Controls" TagPrefix="dxsc" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v11.1" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>

<dx:ASPxCallback ID="cbValidation" runat="server" ClientInstanceName="cbValidation" OnCallback="cbValidation_Callback">
    <ClientSideEvents CallbackComplete="function(s, e) { 
        validatedOnServer = true;
        if (e.result == 'valid') {
            tbPrice.SetIsValid(true); 
        }
        else {
            tbPrice.SetIsValid(false); 
            tbPrice.SetErrorText(e.result);
        }
        OnUpdateControlValue(s, e); 
    }" />
</dx:ASPxCallback>

<table class="dxscAppointmentForm" cellpadding="0" cellspacing="0" style="width: 100%; height: 230px;">
    <tr>
        <td class="dxscDoubleCell" colspan="2">
            <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="dxscLabelCell">
                        <dxe:ASPxLabel ID="lblSubject" runat="server" AssociatedControlID="tbSubject" Text="Subject:">
                        </dxe:ASPxLabel>
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxTextBox ClientInstanceName="tbSubject" ID="tbSubject" runat="server" Width="100%" Text='<%# ((UserAppointmentFormTemplateContainer)Container).Appointment.Subject %>' >
                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ValidationGroup="CustomAppointmentForm">
                                <RequiredField ErrorText="The Subject must contain at least one character." IsRequired="True" />
                            </ValidationSettings>
                            <ClientSideEvents ValueChanged="function(s, e) { OnUpdateControlValue(s, e); }" />
                        </dxe:ASPxTextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr> 
        <td class="dxscSingleCell">
            <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="dxscLabelCell">
                        <dxe:ASPxLabel ID="lblLocation" runat="server" AssociatedControlID="tbLocation" Text="Location:">
                        </dxe:ASPxLabel>
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxTextBox ClientInstanceName="_dx" ID="tbLocation" runat="server" Width="100%" Text='<%# ((UserAppointmentFormTemplateContainer)Container).Appointment.Location %>' />
                    </td>
                </tr>
            </table>
        </td>
        <td class="dxscSingleCell">
            <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="dxscLabelCell" style="padding-left: 25px;">
                        <dxe:ASPxLabel ID="lblLabel" runat="server" AssociatedControlID="edtLabel" Text="Label:">
                        </dxe:ASPxLabel>
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxComboBox ClientInstanceName="_dx" ID="edtLabel" runat="server" Width="100%" DataSource='<%# ((UserAppointmentFormTemplateContainer)Container).LabelDataSource %>' />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="dxscSingleCell">
            <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="dxscLabelCell">
                        <dxe:ASPxLabel ID="lblStartDate" runat="server" AssociatedControlID="edtStartDate" Text="Start time:" Wrap="false">
                        </dxe:ASPxLabel>
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxDateEdit ClientInstanceName="_dx" ID="edtStartDate" runat="server" Width="100%" Date='<%# ((UserAppointmentFormTemplateContainer)Container).Start %>' EditFormat="DateTime" />
                    </td>
                </tr>
            </table>
        </td>
        <td class="dxscSingleCell">
            <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="dxscLabelCell" style="padding-left: 25px;">
                        <dxe:ASPxLabel runat="server" ID="lblEndDate" Text="End time:" Wrap="false" AssociatedControlID="edtEndDate"/>
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxDateEdit id="edtEndDate" runat="server" ClientInstanceName="_dx" Date='<%# ((UserAppointmentFormTemplateContainer)Container).End %>'
                            EditFormat="DateTime" Width="100%">
                        </dxe:ASPxDateEdit>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="dxscSingleCell">
            <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="dxscLabelCell">
                        <dxe:ASPxLabel ID="lblStatus" runat="server" AssociatedControlID="edtStatus" Text="Show time as:" Wrap="false">
                        </dxe:ASPxLabel>
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxComboBox ClientInstanceName="_dx" ID="edtStatus" runat="server" Width="100%" DataSource='<%# ((UserAppointmentFormTemplateContainer)Container).StatusDataSource %>' />
                    </td>
                </tr>
            </table>
        </td>
        <td class="dxscSingleCell" style="padding-left: 22px;">
            <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                <tr>
                    <td style="width: 20px; height: 20px;">
                        <dxe:ASPxCheckBox ClientInstanceName="_dx" ID="chkAllDay" runat="server" Checked='<%# ((UserAppointmentFormTemplateContainer)Container).Appointment.AllDay %>' />
                    </td>
                    <td style="padding-left: 2px;">
                        <dxe:ASPxLabel ID="lblAllDay" runat="server" Text="All day event" AssociatedControlID="chkAllDay" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
<% if(CanShowReminders) { %>
        <td class="dxscSingleCell">
<% } else { %>
        <td class="dxscDoubleCell" colspan="2">
<% } %>
            <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="dxscLabelCell">
                        <dxe:ASPxLabel ID="lblResource" runat="server" AssociatedControlID="edtResource" Text="Resource:">
                        </dxe:ASPxLabel>
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxComboBox ClientInstanceName="_dx" ID="edtResource" runat="server" Width="100%" DataSource='<%# ((UserAppointmentFormTemplateContainer)Container).ResourceDataSource %>' Enabled='<%# ((UserAppointmentFormTemplateContainer)Container).CanEditResource %>' />
                    </td>
                </tr>
            </table>
        </td>
<% if(CanShowReminders) { %>
        <td class="dxscSingleCell">
            <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="dxscLabelCell" style="padding-left: 22px;">
                        <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="width: 20px; height: 20px;">
                                    <dxe:ASPxCheckBox ClientInstanceName="_dx" ID="chkReminder" runat="server"> 
                                        <ClientSideEvents CheckedChanged="function(s, e) { OnChkReminderCheckedChanged(s, e); }" />
                                    </dxe:ASPxCheckBox>
                                </td>
                                <td style="padding-left: 2px;">
                                    <dxe:ASPxLabel ID="lblReminder" runat="server" Text="Reminder" AssociatedControlID="chkReminder" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="dxscControlCell" style="padding-left: 3px">
                        <dxe:ASPxComboBox  ID="cbReminder" ClientInstanceName="_dxAppointmentForm_cbReminder" runat="server" Width="100%" DataSource='<%# ((UserAppointmentFormTemplateContainer)Container).ReminderDataSource %>' />
                    </td>
                </tr>
            </table>
        </td>
<% } %>
    </tr>
    <tr>
        <td class="dxscSingleCell">
            <table class="dxscLabelControlPair" cellpadding="0" cellspacing="0">
                <tr>
                    <td class="dxscLabelCell">
                        <dxe:ASPxLabel ID="ASPxLabel1" runat="server" AssociatedControlID="tbPrice" Text="Price:">
                        </dxe:ASPxLabel>
                    </td>
                    <td class="dxscControlCell">
                        <dxe:ASPxTextBox ID="tbPrice" runat="server" ClientInstanceName="tbPrice" Width="100%" Text='<%# ((UserAppointmentFormTemplateContainer)Container).Field1 %>' BackColor="Ivory">
                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ValidationGroup="CustomAppointmentForm">
                                <RegularExpression ErrorText="Enter the Price value as a positive decimal." ValidationExpression="(^(\d*)\.(\d*)$)|(^\d*$)" />
                                <RequiredField ErrorText="The Price cannot be blank." IsRequired="True" />
                            </ValidationSettings>
                            <ClientSideEvents ValueChanged="function(s, e) { OnUpdateControlValue(s, e); }" Validation="function(s, e) { OnPriceValidate(s, e); }" KeyDown="function(s, e) { validatedOnServer = false; }" />
                        </dxe:ASPxTextBox>
                    </td>
                </tr>
            </table>
            </td>
            <td class="dxscSingleCell" colspan="2">
            </td>

    </tr>
    <tr>
        <td class="dxscDoubleCell" colspan="2" style="height: 90px;">
            <dxe:ASPxMemo ClientInstanceName="_dx" ID="tbDescription" runat="server" Width="100%" Rows="3" Text='<%# ((UserAppointmentFormTemplateContainer)Container).Appointment.Description %>' />
            &nbsp;
        </td>
    </tr>
</table>
                        
<dxsc:AppointmentRecurrenceForm ID="AppointmentRecurrenceForm1" runat="server"
    IsRecurring='<%# ((UserAppointmentFormTemplateContainer)Container).Appointment.IsRecurring %>' 
    DayNumber='<%# ((UserAppointmentFormTemplateContainer)Container).RecurrenceDayNumber %>' 
    End='<%# ((UserAppointmentFormTemplateContainer)Container).RecurrenceEnd %>' 
    Month='<%# ((UserAppointmentFormTemplateContainer)Container).RecurrenceMonth %>' 
    OccurrenceCount='<%# ((UserAppointmentFormTemplateContainer)Container).RecurrenceOccurrenceCount %>' 
    Periodicity='<%# ((UserAppointmentFormTemplateContainer)Container).RecurrencePeriodicity %>' 
    RecurrenceRange='<%# ((UserAppointmentFormTemplateContainer)Container).RecurrenceRange %>' 
    Start='<%# ((UserAppointmentFormTemplateContainer)Container).RecurrenceStart %>' 
    WeekDays='<%# ((UserAppointmentFormTemplateContainer)Container).RecurrenceWeekDays %>' 
    WeekOfMonth='<%# ((UserAppointmentFormTemplateContainer)Container).RecurrenceWeekOfMonth %>' 
    RecurrenceType='<%# ((UserAppointmentFormTemplateContainer)Container).RecurrenceType %>'
    IsFormRecreated='<%# ((UserAppointmentFormTemplateContainer)Container).IsFormRecreated %>' >
</dxsc:AppointmentRecurrenceForm>
                   
<table cellpadding="0" cellspacing="0" style="width: 100%; height: 35px;">
    <tr>
        <td style="width: 100%; height: 100%;" align="center">
            <table style="height: 100%;">
                <tr>
                    <td>
                        <dxe:ASPxButton runat="server" ClientInstanceName="btnOk" ID="btnOk" Text="OK" UseSubmitBehavior="false" AutoPostBack="false" 
                            EnableViewState="false" Width="91px">
                            <ClientSideEvents Init="function(s, e) { OnUpdateControlValue(s, e); }" />
                        </dxe:ASPxButton>
                    </td>
                    <td>
                        <dxe:ASPxButton runat="server" ClientInstanceName="_dx" ID="btnCancel" Text="Cancel" UseSubmitBehavior="false" AutoPostBack="false" EnableViewState="false" 
                            Width="91px" CausesValidation="False" />
                    </td>
                    <td>
                        <dxe:ASPxButton runat="server" ClientInstanceName="_dx" ID="btnDelete" Text="Delete" UseSubmitBehavior="false"
                            AutoPostBack="false" EnableViewState="false" Width="91px"
                            Enabled='<%# ((UserAppointmentFormTemplateContainer)Container).CanDeleteAppointment %>'
                            CausesValidation="False" />
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<table cellpadding="0" cellspacing="0" style="width: 100%;">
    <tr>
        <td style="width: 100%;" align="left">
            <dxsc:ASPxSchedulerStatusInfo runat="server" ID="schedulerStatusInfo" Priority="1" MasterControlId='<%# ((DevExpress.Web.ASPxScheduler.AppointmentFormTemplateContainer)Container).ControlId %>' />
        </td>
    </tr>
</table>
<script id="dxss_ASPxSchedulerAppoinmentForm" type="text/javascript">
    function OnChkReminderCheckedChanged(s, e) {
        var isReminderEnabled = s.GetValue();
        if (isReminderEnabled)
            _dxAppointmentForm_cbReminder.SetSelectedIndex(3);
        else
            _dxAppointmentForm_cbReminder.SetSelectedIndex(-1);
            
        _dxAppointmentForm_cbReminder.SetEnabled(isReminderEnabled);
    }
    
    var validatedOnServer = false;
    
    function OnPriceValidate(s, e) {
        if(e.isValid && !validatedOnServer) {
            var value = parseFloat(e.value);
            e.isValid = false;
            e.errorText = "Server-side validation...";
            cbValidation.PerformCallback(e.value.toString());
        }
    }
    
    function OnUpdateControlValue(s, e) {
        btnOk.SetEnabled(tbSubject.GetIsValid() && tbPrice.GetIsValid());
    }
    
    window.setTimeout("ASPxClientEdit.ValidateGroup('CustomAppointmentForm')", 0);
</script>