<%@ taglib prefix="s" uri="/struts-tags"%>
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
p{
font-size: 10px;
font-family: Tahoma;
align: justify;
}
ul{
font-size: 10px;
font-family: Tahoma;
}

.tableborder {
    border: 1px solid black;
    border-collapse: collapse;
}
 fieldSet
    {
        
    
        border-width: 1px; border-color: rgb(250,235,215);
       
        margin:0;
    }

    legend
    {

        border-style:none;
        background-color:#FFF;
        padding-left:1px;

    }
</style> 

</head>
<body bgcolor="white" style="font-size:10px;" >
<div id="mainBG" class="homeContent" data-type="background">
<form id="frmLeasePrint" action="saveLeasePrint" method="post" autocomplete="off">

<!-- <div  class='hidden-scrollbar'> -->
<div style="background-color:white;">

<table width="100%">
  <tr>
    <td width="26%" rowspan="2"><img src="<%=contextPath%>/icons/epic.jpg" width="100" height="91"  alt=""/></td>
    <td width="74%" style="font-size: 8px;font-family: Tahoma;"><center>www.epicrentacar.com - 800.EPIC(3742) - P.O.BOX 112768.Abu Dhabi .U.A.E</center></td>
  </tr>
  <tr>
    <td><b><font size="5PX">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>Master Lease Agreement</u></font></b></td>
  </tr>
</table>

<table width="100%">
<tr>
<td width="2%">&nbsp;</td> 
<td width="45%">
    
<p align="justify">This Master lease Agreement  <b>Thursday,28 August 2014</b>  between Epic Rent a Car whose registered of is at P.O. Box 125031 Dubai (which expression shall include its successors and assigns) hereinafter called "Lessor" and</p>
 
<table width="100%" >
    <tr style="font-size: 10px;font-family: Tahoma;"><td width="35%"><b>Customers Name </b></td><td alingn="left"><label id="txtcustomersname" name="txtcustomersname"><s:property value="txtcustomersname"/></label></td>
    <tr style="font-size: 10px;font-family: Tahoma;"><td><b>Address </b></td><td alingn="left"><label id="txtaddress" name="txtaddress"><s:property value="txtaddress"/></label></td></tr>
    <tr style="font-size: 10px;font-family: Tahoma;"><td><b>Contact  </b></td><td alingn="left"><label id="txtcontact" name="txtcontact" ><s:property value="txtcontact"/></label><%-- &nbsp;&nbsp;<b><!-- or --></b>&nbsp;&nbsp;
    <label id="txtorcontact" name="txtorcontact" ><s:property value="txtorcontact"/></label> --%></td></tr>
</table>

<p align="justify">UAE hereinafter called "Lessee" shall form a contractual obligation between both parties.<b>All vehicles covered shall be included in this Lease Agreement.</b></p>
  
<table width="100%" > 
    <tr style="font-size: 10px;font-family: Tahoma;"><td width="32%"><b>Vehicle Details </b></td><td align="left"><label id="vehicledetails" name="vehicledetails"><s:property value="vehicledetails"/></label></td>
    <tr style="font-size: 10px;font-family: Tahoma;"><td><b>Vehicle Duration </b></td><td align="left"><label id="vehduration" name="vehduration"><s:property value="vehduration"/></label></td></tr>
    <tr style="font-size: 10px;font-family: Tahoma;"><td><b>Cost per Month  </b></td><td align="left"><label id="vehcostpermonth" name="vehcostpermonth" ><s:property value="vehcostpermonth"/></label><label id="kmrest" name="kmrest" ><s:property value="kmrest"/></label></td></tr>
</table>

<p align="justify"><b>Service and general Maintenance</b></p>

<p align="justify">For new leased vehicles, the first service will take place as per dealer specifications. A service sticker will be placed in all leased vehicles (top left hand side of the front windscreen) with an odometer reading and a contact number. It is the Lessee's responsibility to advise Epic Rent a Car at least 500 kilometers before the service due date or at least 72 hours in advance.</p>

<p align="justify">The Epic RAC will advise the Lessee with a confirmed appointment at the nearest Lessor's authorized service Centre. It is the Lessee's responsibilities to take make sure the vehicle is ready on the confirmed date & time. A minor service will be completed within 6 hours and a major service within 8 hours. The Lessee will be provided with a Replacement Vehicle only if the service exceeds 24 hours.</p>

<p align="justify">Additional servicing or repairs that are required as a result of misuse or negligence by the Lessee or its appointed driver will be carried out and charged to the Lessee.</p>

<p align="justify"><b>1.&nbsp;&nbsp; Driving License Requirement</b></p>

<p align="justify">Any Lessee appointed driver above the age of 25 years is allowed to drive the leased vehicle. The Lessee shall be responsible to provide driving license and passport copies of the initial driver of the vehicle to the Lessor at the time of signing the lease agreement. Driving license requirements for visitors to the UAE are subject to change and the Lessor will provide up to date information to the Lessee.</p>

<p align="justify"><ul><li align="justify">All employees on UAE residence visa are allowed to drive the leased vehicle provided they have a valid UAE driving license.</li>
  <li align="justify">For employees on visit visa, they must have an International Driving license accompanied by a valid driver's license from the issuing country (restrictions apply for selective countries).</li>
  <li align="justify">Family members of the driver of the leased vehicle are entitled to drive as long as they hold a valid UAE driving license and are above the age of 25.Driving License & passport copies will have to be submitted to the Lessor before they are permitted to drive the vehicle.</li></ul>
 </p><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</td>
<td width="6%">&nbsp;</td>
<td width="45%">
<p align="justify"><ul><li align="justify">It is hereby declared and agreed that if the driver at the time of the accident is less than 25 years of age ,an additional deductible of 10% on the total cost of repair on top of the standard excess agreed. By signing, you agree to these terms.</li>
  <li align="justify">For drivers with new driving License issued in the UAE, where the driver has not driven in any other country and has no supporting document to prove otherwise the</li>  
  <li align="justify">Lessor reserve the right to refuse a leased/rental vehicle or increase the excess liability amount to ensure adequate coverage as a result of the associated risk with a new driver.</li></ul></p>

<p align="justify"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.&nbsp;&nbsp;Lessee Responsibility</b></p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Lessee agrees to the following :</p>

<p align="justify"><ul><li align="justify">Regularly check the oil, water, other fluid levels and tyre pressure in accordance with the owners/manufacturers hand book. Failure to carry out these checks could result in damage to the Leased Vehicle, the repairs for which will be charged to the Lessee.</li>
<li align="justify">Based on the pre-appointed dates provided by Epic RAC, Lessee agrees to make sure vehicle is ready for servicing.</li>
<li align="justify">To keep the Leased Vehicle or Replacement Vehicle regularly cleaned inside and outside.</li>
<li align="justify">Remove all personal items of value in the vehicle prior to exchanging or returning it to the Lessor upon lease expiry. The Lessor will not be responsible for personal belongings left in the vehicle.</li>
<li align="justify">Shall not repair or attempt to repair or modify the vehicles without the consent of the  Lessor; If any item of equipment is in the opinion of either party to the contract in need of repair, the further use thereof may be stopped until it has been inspected and, if necessary repaired by the Lessor.</li>
<li align="justify">Responsible for all damage on the leased car or replacement car that is detected and not previously recorded and agreed between the Lessee and the Lessor. The Lessee is responsible to carefully examine at the time of vehicle exchange and advise the Lessor of any unrecorded damage. This liability includes loss of accessories and equipment provided as part of the leased and/or replacement vehicle.</li>
<li align="justify">If a vehicle driven by the Lessee is certified as a total loss irrespective of fault,the current  Lease contract will need to be terminated and a new contract signed based on new Lease rates (based on prevailing available models at the time of incident).Premature termination clause will be applicable if a new contract is not signed up.</li>
</ul></p>

<p align="justify"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.&nbsp;&nbsp;Fuel Costs</b></p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Lessee will be responsible for all fuel related costs on the leased and the Replacement vehicle. The New and Replacement vehicle will be supplied initially with a minimum level of fuel and the Lessee must return them at the same level. If returned above the minimum level no credit is to be provided.</p>

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

</td>
<td width="2%">&nbsp;</td>
</tr></table>    

			<!-- Page 2 -->
			
<table width="100%">
<tr>
<td width="2%">&nbsp;</td>
<td width="45%">

<p align="justify"><b>4.&nbsp;&nbsp;Signage/Alteration</b></p>

<p align="justify">Any signage addition and alteration to the original Leased vehicle can be carried out with a prior written approval of the Lessor.</p>

<p align="justify">The Lessee will be allowed to brand the leased vehicle, the cost for branding or any cost impose by the Government as a result will be borne by the Lessee. The Lessee would be required to provide the Lessor with guide lines for the</p>

<p align="justify">Branding. Cost to remove the branding when the vehicle is off hired is to be borne by the Lessee.</p>

<p align="justify">The lessee will be responsible for any damage or wear & tear on branding.</p>

<p align="justify"><b>5.&nbsp;&nbsp; Vehicle Usage</b></p>

<p align="justify">The Lessee undertakes that the Leased Vehicle will not be used for :</p>

<p align="justify"><ul><li align="justify">Any purpose other than that for which the Leased Vehicle has been designed, including not exceeding its designed load capacity.</li>
  <li align="justify">Racing or any other kind of competitive sport.</li>
  <li align="justify">Carrying passengers, goods or animals for hire.</li>
  <li align="justify">Transportation of hazardous, explosive or inflammable material or any goods or items that are likely to damage the Vehicle-interior, exterior or mechanical functions.</li>
  <li align="justify">Transportation of illegal substances.</li>
  <li align="justify">Any activities which will render the Lessor's insurance cover void or result in the vehicle being impounded by the Authorities.</li>
  <li align="justify">4 Wheel Drive vehicles are for paved road driving only. Desert driving use is not permitted. Customers will be charged in full for any damage caused by Off-Road Driving.</li>
  <li align="justify">Smoke in the Rental car. There is a no-smoking policy in all our vehicles.AED 350 Grooming Fee will be charged if the hirer is in breach of the policy.</li></ul></p>
 
<p align="justify"><b>6.&nbsp;&nbsp; Total Loss</b></p>

<p align="justify">In case of loss of Asset due to Accident/Theft/Hi-Jacking or any other reason, Rental Agreement will remain open and shall raise Invoices toward monthly rental charges, until such time we receive the Final Police Report suitable for insurance claim is not admissible, then the Rental Agreement will remain open and chargeable till the cost of the repair is accepted.</p>

<p align="justify">The client is not relieved of its obligations under this Master Agreement, including the obligation to pay the Fixed Monthly Cost, by reason of Leased Vehicle being involved in an accident or unavailable to the Client during repair.</p>

<p align="justify"><b>7.&nbsp;&nbsp; Mileage</b></p>

<p align="justify">This Lease Agreement assumes a maximum mileage of <b>40,000 KM</b> per year as per rental contract. In case of excess mileage, the Lessee will be charged an additional amount of 0.35 Fils per km thereafter. The excess will be invoiced yearly and calculated based on the vehicle odometer, including any replacement vehicles.</p>

<p align="justify"><b>8.&nbsp;&nbsp;Tire Policy</b></p>

<p align="justify">We shall not be liable for any damage resulting in tire damage caused by a puncture, cut or bursting of any tire, or damage to any tire by application of hard breaking. With the exception of tire damage accruing as a direct result of an accident and an valid Police report has been obtained. The cost of any tire and/or repair will be billed back to the customer.</p>

</td>
<td width="6%">&nbsp;</td>
<td width="45%">

<p align="justify"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;9.&nbsp;&nbsp;Payment/Invoicing</b></p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Billing cycle will be Monthly in advance and AED 1500 security deposit to be held on your account until the vehicle is returned. Epic has the right to terminate the contract as per paragraph 11.Termination for contracts/default.</p>

<p align="justify"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;10.&nbsp;&nbsp;No-Smoking Policy</b></p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;There is a no-smoking policy in all our vehicles.A AED 350 Grooming Fee will be charged if the hirer is in breach of the policy.</p>

<p align="justify"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;11.&nbsp;&nbsp;Termination for Contracts/Default</b></p>

<p align="justify"><ol type="a"><li align="justify">If the Client fails to pay any sum due under this agreement or any sum due under any other agreement between M/s Epic and the Client within seven (7)days of its due date and remains in  default with no remedy for a period of thirty (30)days of service of written notice after the credit facility ;or</li>
<li align="justify">The client fails to observe  or perform or is in persistent breach of any  of the other terms and conditions of this agreement, and if such failure is not remedied within thirty(30)days of service of written notice by Epic-after the credit facility- advising of such default and requiring that such default be remedied; or </li>
<li align="justify">The Client is unable to pay any of it debts or is liable to be wound up by a court of competent jurisdiction or enters in to any liquidation or has a receiver or administrator appointed over all or arrangement  its creditors or a moratorium is declared in respect of any indebtedness or an creditor action,</li></ol></p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Then,Epic may, without prejudice to any other right under this agreement, forthwith terminate this agreement by serving a written notice of termination with direct effect on the Client and may claim compensation calculated from date of termination until the date of receiving the vehicle and further costs of maintenance, spare parts, period of not working, and all expenses occurred to Epic due the breach and default of this agreement including Court fees and Attorney fees shall be Bourne and payable by the Client to Epic.</p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The client shall, after the termination or expiry of this agreement, ensure that the Leased Vehicle is kept in good repair and liable for any damage to the Vehicle and shall immediately  provide notice to Epic and Epic's nominated insurer of any damage to the Leased Vehicle.</p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If Epic_ who is entitled to_ did not terminate this agreement  then, without prejudice to the rights of Epic, may bring a claim of costs  of maintenance, costs of spare parts, period of not working, and claim for all the damages for breach of this agreement including attorney fees and Court fees, and the Client shall forthwith upon written notification from Epic pay all outstanding sums payable to Epic under this agreement together with all payments due to Epic.</p>

<p align="justify"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;12.&nbsp;&nbsp;Early termination Penalty</b></p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If we terminate your service for nonpayment or other default before the end of the Service Commitment, or if you terminate your service for any reason other than (a) in accordance with the cancellation policy; or (b) pursuant  to a change of terms, conditions or rates as set forth below, you agree to pay us with respect to each vehicle assigned to you, in  addition to all other amounts owed, an Early Termination Fee in the amount specified below.("Early Termination Fee").</p>

</td>
<td width="2%">&nbsp;</td>
</tr></table><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>    

			<!-- Page 3 -->
			
<table width="100%">
<tr>
<td width="2%">&nbsp;</td>
<td width="45%">

<p align="justify"><ol type="a"><li align="justify">If your Service Commitment agreement was to run 12 consecutive months, then the early termination would be one month rental charges for each vehicle to be returned.</li>
  <li align="justify">If your Service Commitment agreement was to turn for 24 consecutive months, then the early termination Fee would be two months rental charges for each vehicle to be returned.</li>
  <li align="justify">If your Service commitment agreement  was to run for 36 consecutive months, then the early termination Fee would be three months rental charges for each vehicle to be returned.</li></ol></p>

<p align="justify">The Early Termination Fee is not a penalty,but rather a charge to compensate us for your failure to satisfy the Service Commitment on which your rate plan was priced.</p>

<p align="justify"><b>13.&nbsp;&nbsp;New Vehicle ordering process</b></p>

<p align="justify">The vehicle's can be delivered within same day, if Vehicles are subjected to availability from the dealer.</p>

<p align="justify"><b>14.&nbsp;&nbsp;Insurance Coverage</b></p>

<p align="justify">All Vehicles are insured comprehensively in the UAE with a damage excess of AED 1000.The damage excess will not be charged in case where the Lessee driver is not at fault and there is a third party involved and the amount can be recovered from the third party insurance company. If the leased vehicle has been damaged by an unknown third party, the lessee will be liable to pay the excess amount only, provided a police report or police repair slip has been provided within 48 hours. In the absence of a police report Lessee will be liable to pay the entire cost of repairs to the vehicle.</p>

<p align="justify">The Client accepts liability for any claim for damage or accident that occurs when the driver of a Leased Vehicle has been under the influence of alcohol or drugs, or does not hold a valid UAE license, or a police report either states that the law has been broken or that insurance cover is invalid, and shall pay all fines and pay for all costs or repair and all costs borne by Epic including those of any replacement vehicles and all charges made by Epic's insurance company.</p>

<p align="justify">Customer can remove their excess liability by buying additional insurance called, CDW ( collision Damage waiver).In all cases a valid police report must be obtained for each incident.</p>

<p align="justify">Items Not Covered by the Excess liability are :</p>

<p align="justify"><ul><li align="justify">Driver abuse and non-fair Wear and Tear.</li>
  <li align="justify">Accident damage caused by the Lessee and not claimable/recovered against the Lessor's insurance policy or third party.</li>
  <li align="justify">Replacement tools or equipment for use by the Driver.</li></ul></p>

<p align="justify">The Lessee will be responsible for all vehicle damage costs and any other costs related to the incident if the Lessee driver is found to be under the influence of drugs and/or alcohol.</p>

<p align="justify">For coverage in Oman the lessee would be required to send a written request to the Lessor addressed to the lease coordinator to obtain the Oman insurance certificate. Oman insurance charges applicable are AED 50 per day, AED 350 per week, AED 650 per month and AED 1200 for 6 months which will be invoiced to the Lessee separately.</p>

<p align="justify">For road side assistance in Oman, the Lessee will need to bring the vehicle to the UAE boarder at their own expense (non refundable), once there the Lessor is to be contacted to obtain service support.</p>

<p align="justify">No coverage is provided for loss of Personal Effects in the leased car.</p><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

</td>
<td width="6%">&nbsp;</td>
<td width="45%">

<p align="justify"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15.&nbsp;&nbsp;Traffic Violations</b></p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;All costs incurred as a result of fines and other penalties(imposed by the Police or any other Govt. authorities) that take place during the term of the Lease Contract, will be the Lessee's responsibility to pay on behalf of the drivers and recovered accordingly. There will be a service charge of 10%  on each traffic fine.</p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Epic rent a car will not be responsible for collecting payment from drivers individually (unless in case of Personal Lease) for traffic or parking violations, it is the lessee's responsibility to make this payment on their behalf.</p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A one off charge of AED 50/-will be invoiced to the Lessee for the Salik Tag/s installed in all new Lease vehicle/s.</p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Salik charges will be paid by us on your behalf and you agree to pay all charges associated when using the toll. An additional administration charge of 1 Dhs per crossing for dealing with these matters will be invoiced to your account.</p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>(Sa'ad Report)</b> is  charged to the client (applicable in the following cases) :</p>

<p align="justify"><ul style="list-style-type: circle;"><li align="justify">The accident is caused by the client.</li>
                  <li align="justify">Unknown third party.</li></ul></p>

<p align="justify"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16.&nbsp;&nbsp;Definition of Fair Wear and Tear</b></p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>"Fair Wear and Tear (unavoidable)"</b> means the rendering of an item or component as non-serviceable virtue of time and normal wear cost of which will be borne by the Lessor.</p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Items included in this category include :</p>

<p align="justify"><ul><li align="justify">Routine maintenance.</li>
  <li align="justify">Clutch/brake lining replacement at normal life.</li>
  <li align="justify">The replacement of tyres will depend on normal wear and tear. Repair of punctures and leaking valves is Lessee's responsibility.</li></ul></p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>"Non-Fair Wear and Tear (avoidable)"</b> means the rendering of an item or component as non-serviceable by the action of the Operator which means that the component has to be changed prematurely due to breakage, damage or accelerated wear.</p>

<p align="justify">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Items included in this category include :</p>

<p align="justify"><ul><li align="justify">Breakage or damage to lenses, mirrors, number plates, body panels including wings, mud flaps, brake lines and coupling.</li>
  <li align="justify">Breakage or damage to the brake components and axles due to vehicle bottoming on soft round.</li>
  <li align="justify">Breakage or damage due to impact resulting in damage to axles, road spring, suspension etc.</li>
  
  <li align="justify">All engine and transmission repairs due to the failure of the Operator to maintain correct levels and use of lubricant or coolant.</li>
  <li align="justify">All engine and transmissions/axles as a result of over revving/over loading or over stressing of components, i.e. half shafts, prop shaft, missing or broken teeth on gear assemblies.</li>
  <li align="justify">All cost associated with the Operator losing keys or items belonging to the Lessor which were provided with the vehicle the commencement of or during the lease period.</li>
  <li align="justify">Cost associated with replacements of tyres, where the tyre has not reached the legal limits or normal life and requires replacement due to negligence or misuse such a impact damage.</li></ul></p>
  <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</td>
<td width="2%">&nbsp;</td>
</tr></table>

			<!-- Page 4 -->
			
<table width="100%">
<tr>
<td width="2%">&nbsp;</td>
<td width="45%">

<p><ul><li align="justify"> The lessor shall refer any dispute to the supplying dealer for evaluation and their decision will be final and binding to both parties. </li>
  </ul></p>
  
<p align="justify"><b>17.&nbsp;&nbsp;Road side Assistance Service</b></p>

<p align="justify">In case of any roadside emergency, the lessee can call toll free number (800-EPIC) 3742 during normal office hours.24 hours service is available on +971505825112.</p>

<p align="justify"><b>18.&nbsp;&nbsp;Lease Expiry</b></p>

<p align="justify"><ol type="a"><li align="justify">The lessee is responsible to notify the Lessor on the intention to off hire/terminate the lease vehicle, three months prior to expiration of the lease contract.</li>
  <li align="justify">On the expiration of the Lease contract, the Lessee shall return the leased vehicle to the Lessor in a condition, compatible with the age of the vehicle and kilometers driven. On the return of the Leased Vehicle, the Lessor will inspect the vehicle for damages, repairs that are required and if not considered as fair wear and tear, the repairs will be charged to the account of the Lessee. Decision taken by the Lessor shall be final and binding on the Lessee. Lessor shall inform the lessee prior to its carrying out the repairs.</li>
  <li align="justify">If the Lessee wishes to extend the contract over the initial agreed period, the Lessor will negotiate with the Lessee a new rate for the extension.</li></ol></p>

<p align="justify"><b>19.&nbsp;&nbsp;Waiver or Variation</b></p>
 
<p align="justify">No waiver or variation of these terms and conditions in this Lease Agreement shall be effective, unless recorded in writing and signed by both the Lessor and the Lessee.</p><br/>

<table width="100%" class=tableborder >
  <tr class=tableborder>
    <td class=tableborder height="25" colspan="2" align="left"><b>For Lessee</b></td>
    <td class=tableborder width="54%" align="left"><b>For Lessor </b>&nbsp;<label id="ss" name="ss"><s:property value="ss"/></label></td>
  </tr>
   <tr class=tableborder> 
    <td class=tableborder height="25" colspan="2" align="left">&nbsp;&nbsp;<label id="clientnames" name="clientnames"><s:property value="clientnames"/></label></td>
    <td class=tableborder width="54%" align="left">&nbsp;&nbsp;<label id="lbllessorcompany" name="lbllessorcompany"><s:property value="lbllessorcompany"/></label></td>
  </tr>
  <tr class=tableborder>
    <td colspan="2" > 
  <table width="100%" >
       <tr height="25">
	    <td>Name :</td>
        <td width="68%"><label id="lbllesseename" name="lbllesseename"><s:property value="lbllesseename"/></label></td>
	  </tr>
	  <tr height="10" >
	    <td colspan="2">Title :</td>
        <td colspan="2"><label id="lbllessetitle" name="lbllessetitle"><s:property value="lbllessetitle"/></label></td>
	  </tr>
	  <tr height="10"  >
	    <td colspan="2">Date :</td>
        <td colspan="2"><label id="lbllessedate" name="lbllessedate"><s:property value="lbllessedate"/></label></td>
	  </tr>
	  <tr height="10" >
	    <td colspan="4">Stamp</td>
	  </tr>
	  <tr>
	    <td colspan="4" height="70">&nbsp;</td>
	  </tr>
</table>  
    </td>
     <td colspan="2" class=tableborder>
  <table width="100%">
       <tr height="25">
	    <td colspan="2">Name :</td>
        <td width="68%" colspan="2"><label id="lbllessorname" name="lbllessorname"><s:property value="lbllessorname"/></label></td>
	  </tr>
	  <tr height="10">
	    <td colspan="2">Title :</td>
        <td colspan="2"><label id="lbllessortitle" name="lbllessortitle"><s:property value="lbllessortitle"/></label></td>
	  </tr>
	  <tr height="10">
	    <td colspan="2">Date :</td>
        <td colspan="2"><label id="lbllessordate" name="lbllessordate"><s:property value="lbllessordate"/></label></td>
	  </tr>
	  <tr height="10">
	    <td colspan="4">Stamp</td>
	  </tr>
	  <tr>
	    <td colspan="4" height="70">&nbsp;</td>
	  </tr>
</table></td>
  </tr>
</table><br/>


<table width="100%">
       <tr>
	    <td>&nbsp;</td>
	  </tr>
</table><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>



</td>
<td width="6%">&nbsp;</td>
<td width="45%">

</td>
<td width="2%">&nbsp;</td>
</tr></table>

</div>
</form>
</div>
</body>
</html>
