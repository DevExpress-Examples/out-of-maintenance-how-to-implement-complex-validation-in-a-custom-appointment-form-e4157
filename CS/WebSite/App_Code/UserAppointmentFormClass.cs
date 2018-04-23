using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using DevExpress.Web.ASPxScheduler;
using DevExpress.Web.ASPxScheduler.Internal;
using DevExpress.XtraScheduler;
using DevExpress.Web.ASPxEditors;

#region #userappointmentformtemplatecontainer
public class UserAppointmentFormTemplateContainer : AppointmentFormTemplateContainer {
    public UserAppointmentFormTemplateContainer(ASPxScheduler control)
        : base(control) {
    }
        public double Field1 {
        get {
            object val = Appointment.CustomFields["Field1"];
            return (val == DBNull.Value) ? 0 : Convert.ToDouble(val);
        }
    }
}
#endregion #userappointmentformtemplatecontainer
#region #userappointmentformcontroller
public class UserAppointmentFormController : AppointmentFormController {
    public UserAppointmentFormController(ASPxScheduler control, Appointment apt)
        : base(control, apt) {
    }
    public double Field1 { 
        get { return (double)EditedAppointmentCopy.CustomFields["Field1"]; } 
        set { EditedAppointmentCopy.CustomFields["Field1"] = value; } }

    double SourceField1 { 
        get { return (double)SourceAppointment.CustomFields["Field1"]; } 
        set { SourceAppointment.CustomFields["Field1"] = value; } }

    public override bool IsAppointmentChanged() {
        if(base.IsAppointmentChanged())
            return true;
        return SourceField1 != Field1;
    }
    protected override void ApplyCustomFieldsValues() {
        SourceField1 = Field1;
    }
}
#endregion #userappointmentformcontroller
#region #userappointmentsavecallbackcommand
public class UserAppointmentSaveCallbackCommand : AppointmentFormSaveCallbackCommand {
    public UserAppointmentSaveCallbackCommand(ASPxScheduler control)
        : base(control) {
    }
    protected internal new UserAppointmentFormController Controller { 
        get { return (UserAppointmentFormController)base.Controller; } }

    protected override void AssignControllerValues() {
        ASPxTextBox tbPrice = (ASPxTextBox)FindControlByID("tbPrice");

        Controller.Field1 = Convert.ToDouble(tbPrice.Text);

        base.AssignControllerValues();        
    }
    protected override AppointmentFormController CreateAppointmentFormController(Appointment apt) {
        return new UserAppointmentFormController(Control, apt);
    }
}
#endregion #userappointmentsavecallbackcommand