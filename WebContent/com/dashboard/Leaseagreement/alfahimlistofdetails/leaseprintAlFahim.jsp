<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page pageEncoding="utf-8" %> 
<!DOCTYPE html>
<html>
<% String contextPath=request.getContextPath();%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>GatewayERP(i)</title>
<jsp:include page="../../../../includes.jsp"></jsp:include>
<style>
 .hidden-scrollbar {
  overflow: auto;
  height: 800px;
} 
 fieldSet {
  -webkit-border-radius: 8px;
  -moz-border-radius: 8px;
  border-radius: 8px;
  border: 1px solid rgb(139,136,120);

 }
 .tablereceipt {
    border: 1px solid black;
    border-collapse: collapse;
}
 
 hr { 
   border-top: 1px solid #e1e2df  ;
    
    }
body,p{
text-decoration:none;
}
</style> 
  <%-- <style type="text/css">
    @media screen {
        div.divFooter {
            display: none;
        }
    }
    @media print {
        div.divFooter {
            position: fixed;
            bottom: 0;
        }
    }
 </style>  --%>
 
 
 <script type="text/javascript">

function hidedata()
{

	var first=document.getElementById("firstarray").value;
	var sec=document.getElementById("secarray").value;

	if(parseInt(first)==1) 
		{
		   $("#firstdiv").prop("hidden", false);
		}
	else
		{
		   $("#firstdiv").prop("hidden", true);
		}
	
	if(parseInt(sec)==2)
	{
		  $("#secdiv").prop("hidden", false);
	}
	else
		{
		 $("#secdiv").prop("hidden", true);
		} 
	
	
	}
</script>
</head>
<body style="font-size:10px;"  bgcolor="white" onload="hidedata()">
<div id="mainBG" class="homeContent" data-type="background">
<form id="fmnq" action="priInvoices" autocomplete="off" target="_blank">
<%-- <jsp:include page="../../../../../header.jsp"></jsp:include> --%> <br/> 
<input type="hidden" name="lblchkleaseown" id="lblchkleaseown" value='<s:property value="lblchkleaseown"/>'/>
<s:set name="chkleaseowncount" value="lblchkleaseown" />
 <div style="background-color:white;">
<table width="100%">
  <tr>

  <td><jsp:include page="../../../common/printHeader.jsp"></jsp:include></td>
  
    
 </tr>
 </table>
 
 
 
 <table  style="border-collapse: collapse;" width="100%" border="1">
 <tr height="50" style="background-color: #D8D8D8;border-collapse: collapse;">
 <td align="center" width="30%" style="border-collapse: collapse;"><b>Agreement Number :</b></td>
<td align="left" width="30%" style="border-collapse: collapse;"><b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label id="rentaldoc" name="rentaldoc" ><s:property value="rentaldoc"/></label></b></td>
<td align="center" width="10%" style="border-collapse: collapse;"><b>Date :</b></td>
<td align="center" width="30%" style="border-collapse: collapse;"><b><label id="lbldate" name="lbldate" ><s:property value="lbldate"/></label></b></td>
 </tr>
 </table>
 
 <br>
 
 <h2 align="center">This Lease To Own Option Agreement (The Agreement) is between -</h2>
 
  
  <table style="border-collapse: collapse;" width="100%" border="1" >
  <tr height="50" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="50%" style="border-collapse: collapse;"><b>Details of Lease Parties</b></td>
<td align="center" width="25%" style="border-collapse: collapse;"><b>Lessor/ Seller </b></td>
<td align="center" width="25%" style="border-collapse: collapse;"><b>Lessee / Buyer</b></td>
 </tr>
  <tr style="border-collapse: collapse;">
<td align="center" width="50%" style="border-collapse: collapse;" >Name of Company / Individual- </td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b><label id="companyname" name="companyname"><s:property value="companyname"/></label></b></td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b><label id="clname" name="clname"><s:property value="clname"/></label></b></td>
 </tr> 
  <tr style="border-collapse: collapse;">
<td align="center" width="50%" style="border-collapse: collapse;">Trade License Number- </td>
<td align="center" width="25%" style="border-collapse: collapse;"><b>CN-1007221-1</b></td>
<td align="center" width="25%" style="border-collapse: collapse;"><b>N/A</b></td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="50%" style="border-collapse: collapse;" >Address- </td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b><label id="address" name="address"><s:property value="address"/></label></b></td>
 <td align="center" width="25%" style="border-collapse: collapse;" ><b><label id="claddress" name="claddress"><s:property value="claddress"/></label></b> </td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="50%" style="border-collapse: collapse;" >Notices under this agreement to be sent to </td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b>Malcolm.Cooper@Alfahim.ae</b> </td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b>diahafez@hotmail.com</b></td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="50%" style="border-collapse: collapse;" >Registered Emirate- </td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b>Abu Dhabi</b></td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b></b></td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="50%" style="border-collapse: collapse;" >Emirates I.D. </td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b>N/A</b></td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b><label id="drvemiratesid" name="drvemiratesid"><s:property value="drvemiratesid"/></label></b></td>
 </tr> 
  </table>
  
  <br>
  <p>
  <b>1.	<u>Lease Period</u></b> 
  <br><br>
  This Agreement shall commence on the Lease Agreement date above and is valid for a period of <label name="lbltotalmonths" id="lbltotalmonths"><s:property value="lbltotalmonths"/></label> months ("Lease Period"). 
  <br><br> 
  <b>2.	<u>Lease Vehicle</u></b>
  <br>
  <table style="border-collapse: collapse;" width="100%" border="1">
  <tr height="20" style="border-collapse: collapse;">
<td align="center" width="20%" style="border-collapse: collapse;" ><b>Vehicle</b></td>
<td align="center" width="20%" style="border-collapse: collapse;"><b>Model Year</b></td>
<td align="center" width="20%" style="border-collapse: collapse;"  ><b>Colour</b></td>
<td align="center" width="10%" style="border-collapse: collapse;"><b>Reg Number</b></td>
<td align="center" width="20%" style="border-collapse: collapse;"><b>Chassis</b></td>
<td align="center" width="10%" style="border-collapse: collapse;"><b>VSB</b></td>
 </tr>
  <tr height="20" style="border-collapse: collapse;">
<td align="center" width="20%" style="border-collapse: collapse;"><label id="lblvehicle" name="lblvehicle"><s:property value="lblvehicle"/></label></td>
<td align="center" width="20%" style="border-collapse: collapse;"><label id="lblyom" name="lblyom"><s:property value="lblyom"/></label></td>
<td align="center" width="20%" style="border-collapse: collapse;"><label id="lblcolor" name="lblcolor"><s:property value="lblcolor"/></label></td>
<td align="center" width="10%" style="border-collapse: collapse;"><label id="lblregno" name="lblregno"><s:property value="lblregno"/></label></td>
<td align="center" width="20%" style="border-collapse: collapse;"><label id="lblchassis" name="lblchassis"><s:property value="lblchassis"/></label></td>
<td align="center" width="10%" style="border-collapse: collapse;"><label id="lblvin" name="lblvin"><s:property value="lblvin"/></label></td>
 </tr>
 </table>
 <br>
 <b>3.	<u>Payment Schedule</u></b>
 <br><br>
 
 <br><br>
 <table style="border-collapse: collapse;" width="50%" border="1">
  <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;" ><b>Monthly/ Quarterly Payment<br>Monthly in Arrears</b></td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b>Monthly - <label name="lblrate" id="lblrate"><s:property value="lblrate"/></label> <label name="lblcurrency" id="lblcurrency"><s:property value="lblcurrency"/></label></b></td>
 </tr>
 <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;" ><b>Contract Term<br>Start Date</b></td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b><label name="lbltotalmonths" id="lbltotalmonths"><s:property value="lbltotalmonths"/></label> Months<br><label id="radateout" name="radateout"><s:property value="radateout"/></label></b></td>
 </tr>
 <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;" ><b>Contracted Kilometers<br>Excess</b></td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b><label name="lblcontractkm" id="lblcontractkm"><s:property value="lblcontractkm"/></label> KM <br><label name="lblexcesskmrate" id="lblexcesskmrate"><s:property value="lblexcesskmrate"/></label> <label name="lblcurrency" id="lblcurrency"><s:property value="lblcurrency"/></label> per KM excess</b></td>
 </tr>
 <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;" ><b>Advance Payment<br>Down Payment</b></td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b><label name="lblcurrency" id="lblcurrency"><s:property value="lblcurrency"/></label> <label name="lbladvance" id="lbladvance"><s:property value="lbladvance"/></label><br>None</b></td>
 </tr>
 <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;" ><b>SALIK</b></td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b>5 <label name="lblcurrency" id="lblcurrency"><s:property value="lblcurrency"/></label> per crossing</b></td>
 </tr>
 <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;" ><b>Post Dated Cheque</b></td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b><label name="lblchequecount" id="lblchequecount"><s:property value="lblchequecount"/></label> cheques</b></td>
 </tr>
 <s:if test="#chkleaseowncount > 0">
 <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="25%" style="border-collapse: collapse;" ><b>Lease to Own Option Value</b></td>
<td align="center" width="25%" style="border-collapse: collapse;" ><b> <label name="lblcurrency" id="lblcurrency"><s:property value="lblcurrency"/></label> <label name="lblleaseownamount" id="lblleaseownamount"><s:property value="lblleaseownamount"/></label></b></td>
 </tr>
 </s:if>
 </table>
 <br>
 <p>
<!--  <u>Payments will be paid monthly in advance.</u><br> -->
 <b>Please note the Down Payment will be deducted from the total amount outstanding.</b> 
 <b>The remaining Post Dated Cheques will be taken and begin as per the date on each cheque provided.</b>
 <div style="text-align:justify;">
 	<table style="width:100%;">
 		<tr>
 			<td style="width:5%;">3.1</td>
 			<td style="width:95%;">Without prejudice to the Lessor right to terminate this agreement for any returned cheques by the Lessee, the Lessor  has the right to apply a penalty fee of 2000 AED as an agreed compensation for any cheque return during the agreement term. In such event (if the Lessor choose not to terminate the agreement) the Lessee will have 7 working days to pay the Lessor the amount in full plus the 2000 AED penalty fee. In all events, the Lessor has the right to repossess the vehicle in the event of any returned cheque during the lease period and shall have the right to undertake any and all actions before competent authorities which includes without any limitation, competent courts, traffic and police authorities.</td>
 		</tr>
 		<tr>
 			<td>3.2</td>
 			<td>For Corporate Lease deals Traffic fines and Traffic offences will be invoiced to the lessee at the end of each month.</td>
 		</tr>
 		<tr>
 			<td>3.3</td>
 			<td>Any Police or Court fees will also be invoiced to Lessee at month end.</td>
 		</tr>
 		<tr>
 			<td>3.4</td>
 			<td>The lessee (Private Individual) agrees for the fines to be deducted from the Credit Card supplied at each time of offence. Failure to pay any such fines within 7 days of notice will be considered as a breach of contract and would entitle the Lessor to terminate this agreement.</td>
 		</tr>
 		<tr>
 			<td>3.5</td>
 			<td>Salik will be invoiced to the lessee at the end of each month at 5 AED per crossing.</td>
 		</tr>
 		<tr>
 			<td>3.6</td>
 			<td>All fines and Salik payments are to be made separate from any advance payment held with the lessor.</td>
 		</tr>
 		<tr>
 			<td>3.7</td>
 			<td>An Admin Fee for all fines will be charged at 150 AED</td>
 		</tr>
 	</table>
</div>
 
</p>
 <br>

 <b>4.	<u>Driver Requirements</u></b>
 <br>
 The Lessee warrants and undertakes that: -
 <br>
 <p>
 <div style="text-align:justify;">
 	<table style="width:100%;">
 		<tr>
 			<td style="width:5%;">
 				a.
 			</td>
 			<td style="width:95%;">
 				The Lessee and Spouse are insured to drive the vehicle.
 			</td>
 		</tr>
		<tr>
 			<td style="width:5%;">
 				b.
 			</td>
 			<td style="width:95%;">
 				If this agreement is signed by a Company or legal entity, the Lease Vehicle shall be driven by authorized personnel of the Lessee (“Employee”) within the territory of the United Arab Emirates. The Lessee will be required to provide the Lessor with list and a regular update of Company Employee who shall be driving the Lease Vehicle. 
 			</td>
 		</tr>
		<tr>
 			<td style="width:5%;">
 				c.
 			</td>
 			<td style="width:95%;">
 				All drivers must have given a copy of their valid UAE driving license and Emirates ID copy to the lessor upon verification of the originals. In case the lessee is a legal entity a valid Trade License should be provided. In all cases documents should remain valid throughout the lease period and the lessee undertakes to update and provide the lessor with the renewed documents.
 			</td>
 		</tr>
		<tr>
 			<td style="width:5%;">
 				d.
 			</td>
 			<td style="width:95%;">
 				The drivers of the Lease Vehicle are 25 years of age or above and holding a valid United Arab Emirates driving license issued for 12 months or more.
 			</td>
 		</tr>
		<tr>
 			<td style="width:5%;">
 				e.
 			</td>
 			<td style="width:95%;">
 				In the Event a UAE license is less than 12 months old the Insurance company will consider a Driving License from another country.
 			</td>
 		</tr>
		<tr>
 			<td style="width:5%;">
 				f.	
 			</td>
 			<td style="width:95%;">
 				If Driver is aged between 21 and 25 years of age, any claim would result in Lessee paying 10% of any claim amount.
 			</td>
 		</tr>
		<tr>
 			<td style="width:5%;">
 				g.	
 			</td>
 			<td style="width:95%;">
 				The Lease Vehicle shall not be used for off road driving, motor sports, rallying, towing or any similar irregular activities that may damage the Lease Vehicle. The Lessee is responsible for any damage caused to the Lease Vehicle due to such misuse. The vehicle cannot be sub leased or rented to any 3rd party.
 			</td>
 		</tr>
		<tr>
 			<td style="width:5%;">
 				h.	
 			</td>
 			<td style="width:95%;">
 				During the Leased Period of the Lease Vehicle, the Lessee shall comply with all applicable laws in the UAE 
 			</td>
 		</tr>
</table>
Any failure to comply with the warranties rendered by the Lessee under this clause will entitle the Lessor to terminate this agreement. 

 </div>
 
 
 <br>
</p>
<p>
<b>5.	<u>Insurance</u></b> 
<br>
 <div style="text-align:justify;">
The Lease Vehicle will be insured by the Lessor.<br>
The Insurance Policy will only cover the Named Driver of the leased vehicle on all official roads and areas through-out the United Arab Emirates.<br>
Driving the vehicle Off-Road is strictly out of Insurance coverage.<br>
Driving the vehicle on any Race Track is strictly out of Insurance coverage.<br><br>
Oman Coverage is available with prior consent from the Lessor plus an admin fee Of 250 AED for Insurance Letter. You will also be charged for Orange Card Tariff at the Border.<br>
In the event of a total loss where the lessee is not at fault a replacement vehicle of similar spec and age will be provided until end of contract.<br>
In the event of a total loss where the lessee is at fault, the Lessor has the right terminate the contract immediately.<br>
The lessor is not liable for any personal belongings left or damaged inside on or around the leased vehicle.<br>


</div>
 </p>
 <p>
 
 
 <b>6.	<u>Accidents</u></b> <br>
  <div style="text-align:justify;">
Should the leased vehicle involved in a traffic accident the lessee must contact the relevant police authority immediately.
The lessee must also report the accident / Theft to the lessor within 12 hours.
The lessee will be issued with a receipt or report showing the responsible party for the accident.
In the event of an accident where the lessee is deemed to be responsible based on the police report, an insurance excess of 2000 AED will be charged to the lessee.

Any failure to comply with this clause will entitle the Lessor to terminate this agreement. 

In the event that any damages are not covered under the Insurance Policy the lessee is liable to pay for damages within 30 days of repair.
The repair must be carried out at the Approved service center of the Lessor.

 </div>
 </p>
 
 <br>
 <b>7.	<u>Maintenance </u></b> <br>
 <p>
  <div style="text-align:justify;">
 The Lease Payment includes routine scheduled servicing, tyres and repairs as a result of fair wear and tear. The lessor determines fair wear and tear (fair wear and tear shall be understood as normal damage that naturally and inevitably occurs as a result of normal driving usage and aging during the term of the Contract according to the rules of UAE and standards of the Lessor). 
If the vehicle is due a service or the vehicle displays a warning the lessee must inform the lessor who will arrange a suitable time for the work to be carried out.

The lessee must not carry out any changes on the leased vehicle or add or remove any part/s to the vehicle.
The Vehicle should not be modified without prior request and agreement from the Lessor. This included window tinting.

The Lessee shall not carry out any repairs without the Lessor’s prior written authority otherwise the Lessor will be entitled to terminate this agreement.

The Lessee agrees to keep the leased vehicle in a clean, safe and sound condition at all times.

 </div>
 </p>
 <br>
 <b>8.	<u>Replacement Vehicle </u></b> <br>
 <p>
  <div style="text-align:justify;">
 The Lessor should provide a replacement vehicle to the lessee for the duration of all routine service intervals plus any warranty repair or vehicle malfunction which are not the fault of the driver.

In the event of an accident where the lessee is at fault there is no replacement vehicle given. Full lease payments shall remain due during time of repair.


 </div>
 </p>
 <br>
 <b>9.	Assignment</b> <br>
 <p>
  <div style="text-align:justify;">
Lessee shall not transfer, deliver up possession of, or sublet the leased vehicle or this Agreement, the rights and obligations thereunder shall not be assignable by Lessee without the written consent of the Lessor. Lessor may at any time, whether with or without notice to Lessee, assign, pledge, mortgage, transfer or otherwise dispose of, either in whole or in part, its rights hereunder.
 </div>
 </p><br>
 <b>10.	Events Of Default</b> <br>
 <p>
  <div style="text-align:justify;">
 Any of the following shall each constitute and event of default:
 <table style="width:100%;">
 	<tr>
 		<td style="width:5%;">
 			a)	
 		</td>
 		<td style="width:95%;">
 	The failure of the Lessee to pay any installment of the rental payment or any other sum due under the terms of this Agreement;
 		</td>
 	</tr>
 	<tr>
 		<td style="width:5%;">
 			b)	
 		</td>
 		<td style="width:95%;">
 	The breach of any covenant or condition contained in this Agreement;
 		</td>
 	</tr>
 	<tr>
 		<td style="width:5%;">
 			c)	
 		</td>
 		<td style="width:95%;">
 	The termination, liquidation, sale or cessation of the Lessee’s business;
 		</td>
 	</tr>
 	<tr>
 		<td style="width:5%;">
 			d)	
 		</td>
 		<td style="width:95%;">
 	The subject of Lease Vehicle to any lien, levy, privilege, hypothec or other secured right or any seizure or attachment;
 		</td>
 	</tr>
 	<tr>
 		<td style="width:5%;">
 			e)	
 		</td>
 		<td style="width:95%;">
 	Any assignment by Lessee for the benefit of its creditors;
 		</td>
 	</tr>
 	<tr>
 		<td style="width:5%;">
 			f)	
 		</td>
 		<td style="width:95%;">
 	The admission of Lessee in writing of its inability to pay its debts generally as they become due;
 		</td>
 	</tr>
 	<tr>
 		<td style="width:5%;">
 			g)	
 		</td>
 		<td style="width:95%;">
 	The appointment of a receiver, trustee or similar official for Lessee or for any of its property;
 		</td>
 	</tr>
 	<tr>
 		<td style="width:5%;">
 			h)	
 		</td>
 		<td style="width:95%;">
 	The filing by or against Lessee of a petition in bankruptcy or petition for the reorganization or liquidation of Lessee under the Laws of the UAE.
 		</td>
 	</tr>
 	<tr>
 		<td style="width:5%;">
 			i)	
 		</td>
 		<td style="width:95%;">
 	Any other act of bankruptcy by Lessee.
 		</td>
 	</tr>
 </table>
 </div>
 </p><br>
 <b>11.	Remedies on Default</b> <br>
 <p>
  <div style="text-align:justify;">
Upon the happening of any event of default as stipulated here above, Lessor shall be entitled at any time thereafter to do any one or more of the following without prejudice to any other remedies (mentioned in this Agreement) or right it may have against Lessee:
<table style="width:100%;">
	<tr>
		<td style="width:5%;">
		11.1	
		</td>
		<td style="width:95%;">
		Make such payments or take such steps as may be necessary to remedy the default and, upon demand, recover such payments and Lessor’s costs incurred from Lessee together with any other sums then due and payable under this Agreement;
		</td>
	</tr>
	<tr>
		<td style="width:5%;">
		11.2	
		</td>
		<td style="width:95%;">
		Terminate this Lease and take possession of the Leased Vehicle without demand or notice wherever it may be located and sell, Leased the vehicle upon such terms and conditions as Lessor may deem fit.
		</td>
	</tr>
	<tr>
		<td style="width:5%;">
		11.3	
		</td>
		<td style="width:95%;">
		Recover any  damages and expenses which the Lessor shall have sustainably reason of the Lessee’s breach of this Lease, including but not limited to reasonable sum fees of legal counsel and such expenses as shall be expended or incurred in the seizure, dismantling,  transportation, rental or sale of the Leased Vehicle;
		</td>
	</tr>
	<tr>
		<td style="width:5%;">
		11.4	
		</td>
		<td style="width:95%;">
		All rights and remedies herein provided are cumulative and not exclusive to any other rights or remedies otherwise provided by law. Any single or partial exercise of any right or remedy shall not preclude the further exercise of any   other right or remedy. 
		</td>
	</tr>
</div>
 </p><br>
 <b>12.	<u>Termination</u></b> <br>
 <p>
  <div style="text-align:justify;">
  <table style="width:100%;">
  	<tr>
  		<td style="width:5%;">
  		12.1
  		</td>
  		<td style="width:95%;">
  		The Lessee may terminate this Lease Agreement by serving thirty (30) days written notice on the Lessor. In the event that the Lessee terminates the Lease Agreement within the first twelve months of the Lease Period, the Lessee shall pay a cancellation charge equal to three months of the Lease Payment.  In the case of termination of the Lease Agreement after the first twelve months but prior to completion of the Lease Period, the Lessee will be required to pay a cancellation charge equal to two month of the Lease Payment. 
  		</td>
  	</tr>
  	<tr>
  		<td style="width:5%;">
  		12.2
  		</td>
  		<td style="width:95%;">
  		Without prejudice to the Lessor rights under Clause 10, and without prejudice to the Lessor rights to terminate the agreement immediately pursuant to clause 3, 5, 6 and 9 of this Agreement, the Lessor may terminate the agreement giving the lessee 15 days’ written notice at any time during the Agreement period if there is a breach of contract or any default payments. 
  		</td>
  	</tr>
  	<tr>
  		<td style="width:5%;">
  		12.3
  		</td>
  		<td style="width:95%;">
  		The parties agree and acknowledge that court orders are not required to effect the termination of this agreement and the agreement is deemed terminated without the need to obtain any court proceedings or orders. 
  		</td>
  	</tr>
</div>
 </p>
 
 <b>13.	<u>End of Contract</u></b> <br>
 <p>
  <div style="text-align:justify;">

The lessee must return the vehicle to the lessor at the end of contract term. The vehicle should be clean and in good condition. For each day overdue there will be a daily pro rata rate charged of the monthly payment.<br>
Any damage caused by other reasons than fair wear and tear will be charged to the lessee and directly deducted from the Credit Card.<br>
The lessee may request to purchase the leased vehicle (Lease to Own Option) at any time during or at the end on the contract term. A written notice would need to be given to the lessor.<br>
The sale and terms and conditions would be at the discretion of the lessor.
 </div>
 </p><br>
 <b>14.	<u>Own Option</u></b> <br>
 <p>
  <div style="text-align:justify;">
 This Own Option is hereby incorporated by reference and relates to this Agreement between the parties hereto as identified below.
<table stylw="width:100%;">
	<tr>
		<td style="width:5%;">
		14.1
		</td>
		<td style="width:95%;">
		The Lessee has the option to purchase the Leased Vehicle described in Clause 2 of this Agreement, by expressing its intention to purchase at least 60 days before the end of the Lease Period as described in Clause 1 of this Agreement, for a purchase price in the amount of Ninety Nine Thousand Seven Hundred Fifty Dirhams Only as described in Own Value;
		</td>
	</tr>
	<tr>
		<td style="width:5%;">
		14.2
		</td>
		<td style="width:95%;">
		The Own Option may be exercised if Lessee is not in default under this Agreement both at the time of exercise or through the Lease period (at the case may be).
		</td>
	</tr>
	<tr>
		<td style="width:5%;">
		14.3
		</td>
		<td style="width:95%;">
		The Own Option shall be exercised by Lessee giving notice to that effect in writing to Lessor at least 60 days before the expiry of the Lease Period. 
		</td>
	</tr>
	<tr>
		<td style="width:5%;">
		14.4
		</td>
		<td style="width:95%;">
		Once   the payment has been received in full for the Own Value the Lessor will transfer ownership of the Leased Vehicle to the Lessee.
		</td>
	</tr>
	<tr>
		<td style="width:5%;">
		14.5
		</td>
		<td style="width:95%;">
		Until all installment payments for the Own Value, and all other amounts due under this Agreement, have been paid, Lessor shall retain the title in, and ownership of the Leased Vehicle.
		</td>
	</tr>
	<tr>
		<td style="width:5%;">
		14.6
		</td>
		<td style="width:95%;">
		This Own Option shall ensure to the benefit of and be binding upon the parties hereto and their respective successors and assigns. This Purchase Option is not assignable by Lessee without the prior written consent of Lessor.
		</td>
	</tr>
	<tr>
		<td style="width:5%;">
		14.7
		</td>
		<td style="width:95%;">
		Without prejudice to any other remedies stipulated under this Agreement, if the Lessee in defaults under this Own Option or under this Agreement, then in addition to any other remedies available to Lessor by law;  the Lessor may terminate this Own Option by giving 3 days written notice of the termination. If terminated, the Lessee shall lose entitlement to any refund of rent or option consideration. For this Own Option to be enforceable and effective, the Lessee must comply with all the terms and conditions of this Agreement.
		</td>
	</tr>
</table>
</div>
 </p><br>
 <b>15.	<u>Additional Clauses </u></b> <br>
 <p>
  <div style="text-align:justify;">
 This Lease Agreement shall be governed by the laws in force in the United Arab Emirates, as applicable in the Emirate of Abu Dhabi. Any dispute arising out of or in connection to this agreement shall be settled by the Courts of Abu Dhabi.
<b>The lessor must hold the credit card details of the driver.</b> These details cannot be given to any 3rd party or used outside the terms of this contract. These will be used to charge any Fines for the vehicle being leased.

Future Government charges or tax or VAT may be added should they become applicable.

By Signing the lease contract below you agree that you have read and understood all sections and agree to the terms and conditions in full.

 </div>
 </p><br>
 
 <b>16.	<u>. Peace of Mind Packages.</u></b> <br>
 <p>
  <div style="text-align:justify;">
Lease customer will be given the option to pay a monthly fee for a Peace of Mind packages.

The customer will have the option to pay a premium to allow a replacement vehicle in the event of an accident where they were at fault.

The Customer will also have the option to pay for a monthly premium to cover Insurance Excess in the event of an accident where they were at fault.

 </div>
 </p><br><br><br><br><br><br> <br><br><br><br><br><br>
 <b><h2 align="center">Approval Details</h2></b>
  <br>
  	 <table  width="100%" >
 						<tr>
							  <th width="10%"  align="left"><b>User</b></th>
							  <th width="10%" align="left"><b>Submit</b></th>
							  <th width="30%" align="left"><b>Remarks</b></th>
  						</tr>
     					<s:iterator var="stattraffic" status="arr" value='#request.PRINT' >
								<s:iterator status="arr" value="#stattraffic" var="stattraffic2"> 
									<tr >
 										<s:iterator status="arr" value="#stattraffic2.split('::')" var="destraffic"> 
  											<td ><s:property value="#destraffic"/></td>
  										</s:iterator>
  									</tr>	
  								</s:iterator>
  						</s:iterator>
  			</table>
 
 
 <br>
 </p><br><br><br><br><br><br>
  <table style="border-collapse: collapse;" width="100%">
	  <tr style="border-collapse: collapse;">
	<td align="left" width="8%" style="border-collapse: collapse;">&nbsp;</td>
	<td align="left" width="18%" style="border-collapse: collapse;">Name</td>
	<td align="left" width="23%" style="border-collapse: collapse;">:	Mr. Malcolm Cooper</td>
	<td align="left" width="20%" style="border-collapse: collapse;">Name</td>
	<td align="left" width="31%" style="border-collapse: collapse;">:   <label id="clname" name="clname"><s:property value="clname"/></label></td>
	 </tr>
	 
	  <tr style="border-collapse: collapse;">
	<td align="left" style="border-collapse: collapse;">&nbsp;</td>
	<td align="left" style="border-collapse: collapse;">Designation</td>
	<td align="left" width="23%" style="border-collapse: collapse;">:	General Manager </td>
	<td align="left" width="20%" style="border-collapse: collapse;">Designation</td>
	<td align="left" width="31%" style="border-collapse: collapse;">:   <label id="lbljobtitle" name="lbljobtitle"><s:property value="lbljobtitle"/></label></td>
	 </tr> 
	 <tr style="border-collapse: collapse;">
	<td align="left" style="border-collapse: collapse;">&nbsp;</td>
	<td align="left" style="border-collapse: collapse;">Company Name</td>
	<td align="left" width="23%" style="border-collapse: collapse;">: <label id="lblcompname" name="lblcompname" ><s:property value="lblcompname"/></label></td>
	<td align="left" width="20%" style="border-collapse: collapse;">Company Name</td>
	<td align="left" width="31%" style="border-collapse: collapse;">: <label id="lblclientcompany" name="lblclientcompany"><s:property value="lblclientcompany"/></label></td>
	 </tr> 
  </table>
  <br> <br> <br> <br> <br> <br>
  <table width="100%" border="0">
    <tr>
      <td><p align="center">
  <b> Lessor's Signature and Company Seal</b>
  </p></td>
      <td> <p align="center">
  <b>Lessee's Signature and Company Seal</b>
  </p></td>
    </tr>
  </table>
  <br>  
  
 
  <%-- <jsp:include page="../../../common/printFooter.jsp"></jsp:include>  --%>
<input type="hidden" name="firstarray" id="firstarray" value='<s:property value="firstarray"/>'>
<input type="hidden" name="secarray" id="secarray"  value='<s:property value="secarray"/>'>
</div>
</body>
</html>
  
  
  
  
  
  
  
  
  
  <!-- <br>
  3 months in advance plus monthly Post Dated Cheques.
  <br>
  <b>Security :</b>
  <br>
  Credit Card pre authority for 1500 each month to cover fines and salik
  <br>
  <b>Credit Facility :</b>
  <br>
Available on request for Companies only.
<br>
<b>Driver Requirement :</b>
<br>
Must hold a valid UAE driving license for at least 12 months and be over 25 years old.
<br>
<b>Termination :</b>
<br>
Customer may terminate the lease in writinggiving 30 days notice. 
<br>
During first year termination fee would be 3 x monthly payment.
<br>
After first year termination fee would be 2 x monthly payment.
<br>
<b>Government Fees :</b>
<br>
Salik is charged at 5 AED per crossing
<br>
Admin fee for all traffic fines would be 150 AED.
<br>
<b>Insurance Coverage :</b>
<br>The Insurance coverage excludes All Off Road areas , any Race or Performance track area and countries outside <br>of the UAE. The customer is fully liable for any damage caused due to excluded coverage.
  </p>
  <br>
  <br>
  <table style="border-collapse: collapse;" width="100%" border="1">
  <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;"><b>Documents Req. for Lease approval</b></td>
<td align="left" width="20%"  style="border-collapse: collapse;"></td>
<td align="left" width="40%"  style="border-collapse: collapse;"></td>
 </tr>
 <tr height="40" style="background-color: #D8D8D8;border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;"><b>Private Individual</b></td>
<td align="left" width="20%"  style="border-collapse: collapse;"></td>
<td align="center" width="40%"  style="border-collapse: collapse;"><b>Company</b></td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="40%" >Passport Copy + Visa Copy +EID</td>
<td width="20%"  style="border-collapse: collapse;"></td>
<td align="center" width="40%"  style="border-collapse: collapse;">Valid Trade License<br> Memorandum of association</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;">Salary Certificate</td>
<td width="20%"  style="border-collapse: collapse;"></td>
<td align="center" width="40%"  style="border-collapse: collapse;">Power of Attorney</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;">Driving License</td>
<td align="left" width="20%" style="border-collapse: collapse;" ></td>
<td align="center" width="40%"  style="border-collapse: collapse;">6 Months Bank Statements</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;">3 Months Bank Statements</td>
<td align="left" width="20%" style="border-collapse: collapse;" ></td>
<td align="center" width="40%"  style="border-collapse: collapse;">Owners Passport Copy</td>
 </tr>
 <tr style="border-collapse: collapse;">
<td align="center" width="40%"  style="border-collapse: collapse;">Work + Home Address</td>
<td align="left" width="20%"  style="border-collapse: collapse;"></td>
<td align="center" width="40%"  style="border-collapse: collapse;">Premises Address <br>Signed Credit Application Form</td>
 </tr>
  </table> 
  <p> 
  Thank you : Quotation is valid for 14 days from Date of Quotation and subject to vehicle availability. This<br> 
Quotation is not a Contract and is for information purpose only.
 </p>
 </div>   
<br>-->
