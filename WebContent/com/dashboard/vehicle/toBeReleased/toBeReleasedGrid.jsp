<%@ page import="com.dashboard.vehicle.tobereleased.ClsToBeReleasedDAO" %>
<% ClsToBeReleasedDAO ctrd=new ClsToBeReleasedDAO();%>



<%--  <jsp:include page="../../../../includes.jsp"></jsp:include> --%> 
<%System.out.println("Request"+request.getParameter("brchval")+"After"); %>
 <%String brchval=request.getParameter("brchval")==null||request.getParameter("brchval")==""?"0":request.getParameter("brchval"); %> 
<script type="text/javascript">
      var datarelease;
        $(document).ready(function () {
        //	alert("==="+document.getElementById("cmbbranch").value+"====");
        	<%System.out.println("BRCHVAL"+brchval);%>
if(document.getElementById("cmbbranch").value!=""){
        	datarelease='<%=ctrd.getReleaseData(brchval)%>';
}
        	var num = 0;
        
        	var source =
            {
                datatype: "json",
                datafields: [

{name : 'gid' , type: 'string' },
	{name : 'brand' , type:'string'},
	{name : 'fleet_no' , type:'string'},
	{name : 'flname' , type:'string'},
	{name : 'yom',type:'string'},
	{name : 'color' , type:'string'},
	{name : 'regno' , type:'string'},
	{name :'fuel',type:'string'},
	{name :'km',type:'string'},
	{name :'opstatus',type:'string'},
	{name :'aststatus',type:'string'},
	{name :'branch',type:'string'},
	{name :'doc_no',type:'string'},
	{name : 'purdate',type:'date'}
	
	],
                
                localdata: datarelease,
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
            $("#toBeReleasedGrid").jqxGrid(
            {
                width: '100%',
                height: 525,
                source: dataAdapter,
                columnsresize: true,
                pageable: false,
                altRows: true,
                sortable: true,
                selectionmode: 'singlerow',
                filtermode:'excel',
                filterable: true,
            
                editable:false,
                //Add row method
                columns: [
{ text: 'Group', datafield: 'gid', width: '12.5%'},
{ text: 'Brand',  datafield: 'brand',  width: '12.5%' },
{ text: 'Fleet',  datafield: 'fleet_no',  width: '12.5%'  },
{ text: 'Fleet Name', datafield:'flname', width:'12.5%'},
{ text: 'YoM',  datafield: 'yom',  width: '12.5%' },
{ text: 'Color',  datafield: 'color',  width: '12.5%'},
{ text: 'Reg No',  datafield: 'regno',  width: '12.5%'},
{ text: 'Fuel',  datafield: 'fuel',  width: '12.5%',hidden:true},
{ text: 'KM',  datafield: 'km',  width: '12.5%',hidden:true},
{ text: 'Opstatus',  datafield: 'opstatus',  width: '12.5%',hidden:true},
{ text: 'Ast Status',  datafield: 'aststatus',  width: '12.5%',hidden:true},
{ text: 'Branch',  datafield: 'branch',  width: '12.5%',hidden:true},
{ text: 'Doc No',  datafield: 'doc_no',  width: '12.5%',hidden:true},
{text: 'Purchase Date',datafield:'purdate',width:'12.5%',cellsformat:'dd.MM.yyyy'}
	              ]
            });
            var rows=$("#toBeReleasedGrid").jqxGrid("getrows");
            var rowcount=rows.length;
            if(rowcount==0){
            	$("#toBeReleasedGrid").jqxGrid("addrow", null, {});	
            }
            $('#toBeReleasedGrid').on('rowdoubleclick', function (event) {
            	var rowindex1=event.args.rowindex; 
            	$('input[type=text],[type=hidden]').val('');
         	   $('select').find('option').prop("selected", false);
         	 // document.forms['frmVehicle'].reset();
         	 var url = window.location.href; 
         	
            	document.getElementById("dashreleasefleet").value=$('#toBeReleasedGrid').jqxGrid('getcellvalue', rowindex1, "fleet_no"); 
            	$('#dashcmbrlsbranch').val($("#toBeReleasedGrid").jqxGrid('getcellvalue', rowindex1, "branch")) ;
            	document.getElementById("dashreleasekm").value=$('#toBeReleasedGrid').jqxGrid('getcellvalue', rowindex1, "km");
            	$('#dashreleasefuel').val($("#toBeReleasedGrid").jqxGrid('getcellvalue', rowindex1, "fuel")) ;
            	document.getElementById("dashaststatus").value=$('#toBeReleasedGrid').jqxGrid('getcellvalue', rowindex1, "aststatus");
            	document.getElementById("docno").value=$('#toBeReleasedGrid').jqxGrid('getcellvalue', rowindex1, "doc_no");
            	var temp=$('#toBeReleasedGrid').jqxGrid('getcellvalue', rowindex1, "opstatus");
            	$('#dashreleasedate').jqxDateTimeInput('setDate',$('#toBeReleasedGrid').jqxGrid('getcellvalue', rowindex1, "purdate"));
            	if((temp=='I')||(temp=='i'))
            	document.getElementById("dashopstatus").value="INDUCTED";
            	if((temp=='L')||(temp=='l'))
            		document.getElementById("dashopstatus").value="LIVE";
            	getLocation(document.getElementById("dashcmbrlsbranch").value);
            	
            	document.getElementById("dashbtnrelease").disabled=false;
            	document.getElementById("btnvehicle").disabled=false;
            	document.getElementById("btnattach").disabled=false;
            });

        });
            </script>
            <div id="toBeReleasedGrid"></div>