Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web.ASPxScheduler
Imports DevExpress.Web.ASPxScheduler.Internal
Imports DevExpress.XtraScheduler
Imports DevExpress.Web.ASPxEditors

#Region "#userappointmentformtemplatecontainer"
Public Class UserAppointmentFormTemplateContainer
	Inherits AppointmentFormTemplateContainer
	Public Sub New(ByVal control As ASPxScheduler)
		MyBase.New(control)
	End Sub
		Public ReadOnly Property Field1() As Double
		Get
			Dim val As Object = Appointment.CustomFields("Field1")
			If (val Is DBNull.Value) Then
				Return 0
			Else
				Return Convert.ToDouble(val)
			End If
		End Get
		End Property
End Class
#End Region ' #userappointmentformtemplatecontainer
#Region "#userappointmentformcontroller"
Public Class UserAppointmentFormController
	Inherits AppointmentFormController
	Public Sub New(ByVal control As ASPxScheduler, ByVal apt As Appointment)
		MyBase.New(control, apt)
	End Sub
	Public Property Field1() As Double
		Get
			Return CDbl(EditedAppointmentCopy.CustomFields("Field1"))
		End Get
		Set(ByVal value As Double)
			EditedAppointmentCopy.CustomFields("Field1") = value
		End Set
	End Property

	Private Property SourceField1() As Double
		Get
			Return CDbl(SourceAppointment.CustomFields("Field1"))
		End Get
		Set(ByVal value As Double)
			SourceAppointment.CustomFields("Field1") = value
		End Set
	End Property

	Public Overrides Function IsAppointmentChanged() As Boolean
		If MyBase.IsAppointmentChanged() Then
			Return True
		End If
		Return SourceField1 <> Field1
	End Function
	Protected Overrides Sub ApplyCustomFieldsValues()
		SourceField1 = Field1
	End Sub
End Class
#End Region ' #userappointmentformcontroller
#Region "#userappointmentsavecallbackcommand"
Public Class UserAppointmentSaveCallbackCommand
	Inherits AppointmentFormSaveCallbackCommand
	Public Sub New(ByVal control As ASPxScheduler)
		MyBase.New(control)
	End Sub
	Protected Friend Shadows ReadOnly Property Controller() As UserAppointmentFormController
		Get
			Return CType(MyBase.Controller, UserAppointmentFormController)
		End Get
	End Property

	Protected Overrides Sub AssignControllerValues()
		Dim tbPrice As ASPxTextBox = CType(FindControlByID("tbPrice"), ASPxTextBox)

		Controller.Field1 = Convert.ToDouble(tbPrice.Text)

		MyBase.AssignControllerValues()
	End Sub
	Protected Overrides Function CreateAppointmentFormController(ByVal apt As Appointment) As AppointmentFormController
		Return New UserAppointmentFormController(Control, apt)
	End Function
End Class
#End Region ' #userappointmentsavecallbackcommand