
 <%@page import="com.operations.agreement.rentalclosenew.*"%>
<%@page import="com.common.ClsCommon"%>
<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%
ClsCommon objcommon=new ClsCommon();
ClsRentalCloseNewDAO closedao=new ClsRentalCloseNewDAO();
String agmtno=request.getParameter("agmtno")==null?"0":request.getParameter("agmtno").toString();
String tarif=request.getParameter("tarif")==null?"0":request.getParameter("tarif").toString();
String cdwtotal=request.getParameter("cdwtotal")==null?"0":request.getParameter("cdwtotal").toString();
String acctotal=request.getParameter("acctotal")==null?"0":request.getParameter("acctotal").toString();
String chauffer=request.getParameter("chauffer")==null?"0":request.getParameter("chauffer").toString();
String excesskmchg=request.getParameter("excesskmchg")==null?"0":request.getParameter("excesskmchg").toString();
String excesshrchg=request.getParameter("excesshrchg")==null?"0":request.getParameter("excesshrchg").toString();
String temp=request.getParameter("temp")==null?"0":request.getParameter("temp").toString();
String usedhours=request.getParameter("usedhours")==null?"0":request.getParameter("usedhours").toString();
String clientid=request.getParameter("clientid")==null?"0":request.getParameter("clientid").toString();
String fuel=request.getParameter("fuel")==null?"0":request.getParameter("fuel").toString();
String deliverychg=request.getParameter("deliverychg")==null?"0":request.getParameter("deliverychg").toString();
String collectchg=request.getParameter("collectchg")==null?"0":request.getParameter("collectchg").toString();
String outdate=request.getParameter("outdate")==null?"0":request.getParameter("outdate").toString();
String indate=request.getParameter("indate")==null?"0":request.getParameter("indate").toString();
String cmbinfuel=request.getParameter("cmbinfuel")==null?"0":request.getParameter("cmbinfuel").toString();
String exkm=request.getParameter("exkm")==null?"0":request.getParameter("exkm").toString();
String calctype=request.getParameter("calctype")==null?"0":request.getParameter("calctype").toString();
java.sql.Date closeinvdate=(request.getParameter("closeinvdate")==null || request.getParameter("closeinvdate")=="")?null:objcommon.changeStringtoSqlDate(request.getParameter("closeinvdate"));
String closecalflag=request.getParameter("closecalflag")==null?"0":request.getParameter("closecalflag");
String useddays=request.getParameter("useddays")==null?"":request.getParameter("useddays");
//System.out.println("Out Date in Jsp:"+outdate);
%>

<script type="text/javascript">

var datacalc;
        $(document).ready(function () { 	
        	    var temp1='<%=temp%>';
        	var num = 0;
        	
        	if(temp1=="1" && document.getElementById("docno").value==''){
        		//alert("Inside Temp 1"); 
	        	datacalc='<%=closedao.getCalcData(agmtno,tarif,cdwtotal,acctotal,chauffer,excesskmchg,excesshrchg,temp,session,usedhours,clientid,fuel,deliverychg,collectchg,outdate,indate,cmbinfuel,request,exkm,closeinvdate,closecalflag,calctype,useddays)%>';
        	}
        	else if(temp1=="2" && document.getElementById("docno").value!=''){
        		//alert("Inside Calculation view");
        		datacalc='<%=closedao.getCalcData_view(agmtno)%>';
        	}
        
        	 var rendererstring=function (aggregates){
               	var value=aggregates['sum'];
               	return '<div style="float: right; margin: 4px;font-size:10px; overflow: hidden;">' +  value + '</div>';
               }
                
        	var source =
            {
                datatype: "json",
                datafields: [
{name : 'description' , type: 'string' },
	{name : 'qty' , type:'String'},
	{name : 'total' , type:'number'},
	{name : 'invoice' , type:'number'},
	{name : 'invoiced',type:'number'},
	{name : 'creditnote' , type:'number'},
	{name :'idno',type:'number'},
	{name :'acno',type:'number'},
	{name : 'salamount',type:'number'},
	{name : 'salikrate',type:'number'},
	{name : 'saliksrvc',type:'number'},
	{name : 'salikamt',type:'number'},
	{name : 'trafficamt',type:'number'},
	{name : 'trafficsrvc',type:'number'}
	
                 ],
                
                localdata: datacalc,
                //url: url,
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
            };
            var dataAdapter = new $.jqx.dataAdapter(source,
            		 {
                		loadError: function (xhr, status, error) {
	                    alert(error);    
	                    }
		            }		
            );
           
            $("#calculationgrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: dataAdapter,
                rowsheight:18,
                localization: {thousandsSeparator: ""},
                statusbarheight:25,
                columnsresize: true,
                columnsheight: 15,
                pageable: false,
                altRows: true,
                sortable: false,
                selectionmode: 'singlecell',
             	showaggregates:true,
                showstatusbar:true,
                
                //Add row method
                columns: [
{ text: 'Rate Description', datafield: 'description', width: '25%',editable:false},
{ text: 'Qty',  datafield: 'qty',  width: '20%',editable:true },
{ text: 'Total',  datafield: 'total',  width: '14%'  ,editable:true ,cellsformat: 'd2',cellsalign:'right',align:'right' ,aggregates: ['sum'],aggregatesrenderer:rendererstring},
{ text: 'Invoiced', datafield:'invoiced', width:'14%',editable:true ,cellsformat: 'd2',cellsalign:'right',align:'right',aggregates: ['sum'] ,aggregatesrenderer:rendererstring},
{ text: 'Invoice',  datafield: 'invoice',  width: '14%'  ,editable:true ,cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'Balance',aggregates: ['sum'],aggregatesrenderer:rendererstring},
{ text: 'Credit Note',  datafield: 'creditnote',  width: '13%',editable:true,cellsformat: 'd2',cellsalign:'right',align:'right',columngroup:'Balance',aggregates: ['sum'],aggregatesrenderer:rendererstring},
{ text: 'Id No',  datafield: 'idno',  width: '17.5%',hidden:true},
{ text: 'Ac No',  datafield: 'acno',  width: '17.5%',hidden:true},
{ text: 'Sal Amount',  datafield: 'salamount',  width: '17.5%',hidden:true},
{ text: 'Salik Rate',  datafield: 'salikrate',  width: '17.5%',hidden:true},
{ text: 'Salik Srvc',  datafield: 'saliksrvc',  width: '17.5%',hidden:true},
{ text: 'Salik Amt',  datafield: 'salikamt',  width: '17.5%',hidden:true},
{ text: 'Traffic Amt',  datafield: 'trafficamt',  width: '17.5%',hidden:true},
{ text: 'Traffic Srvc',  datafield: 'trafficsrvc',  width: '17.5%',hidden:true}
], columngroups: 
	                     [
	                       { text: 'Balance', align: 'center', name: 'Balance',width:10 }
	                    
	                     ]
            });
       var rows=$("#calculationgrid").jqxGrid("getrows");
       var rowlength=rows.length;
       
        });
            </script>
            <div id="calculationgrid"></div>