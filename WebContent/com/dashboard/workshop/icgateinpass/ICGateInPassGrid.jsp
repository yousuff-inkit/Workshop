<%@page import="com.dashboard.workshop.icgateinpass.*"%>
<%
ClsWSICGateInPassDAO gatedao=new ClsWSICGateInPassDAO();
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String branch=request.getParameter("branch")==null?"":request.getParameter("branch");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");

%>

<script type="text/javascript">
 
var id='<%=id%>';
var gatedata;

if(id=='1'){
  gatedata='<%=gatedao.getGateInPassData(fromdate,todate,id,branch)%>';
}
else{
gatedata=[];
}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'doc_no',type:'number'},
                  		{name : 'brhid',type:'number'},
                  		{name : 'date',type:'date'},
                  		{name : 'branchname',type:'string'},
                  		{name : 'fleet_no',type:'number'},
                  		{name : 'reg_no',type:'number'},
                  		{name : 'flname',type:'string'},
                  		{name : 'platecode',type:'string'},
                  		{name : 'brand',type:'string'},
                  		{name : 'brandid',type:'string'},
                  		{name : 'modelid',type:'string'},
                  		{name : 'model',type:'string'},
                  		{name : 'yom',type:'number'},
                  		{name : 'outdate',type:'date'},
                  		{name : 'outtime',type:'string'},
                  		{name : 'outkm',type:'number'},
                  		{name : 'outfuel',type:'string'},
                  		{name : 'description',type:'string'},
                  		{name : 'userid',type:'string'},
                  		{name : 'user',type:'string'},
                  		{name : 'driverid',type:'string'},
                  		{name : 'driver',type:'string'},
                  		{name : 'fout',type:'string'},
                  		{name : 'btnview',type:'string'},
                  		{name : 'yomid',type:'string'},
                  		{name : 'chassisno',type:'string'},
                  		{name : 'compno',type:'string'},
                  		{name : 'company',type:'string'}
				
                  		],
				    localdata: gatedata,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#ICgateInPassGrid").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    

    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#ICgateInPassGrid").jqxGrid(
    {
        width: '98%',
        height: 520,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlecell',
       sortable:false,
        columns: [
               
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Company',datafield:'company',width:'12%'},
       				{ text: 'Branch',datafield:'branchname',width:'12%'},
       				{ text: 'Branch Id',datafield:'brhid',width:'12%',hidden:true},
       				{ text: 'Doc No',datafield:'doc_no',width:'6%'},
       				{ text: 'Date',datafield:'date',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Create',datafield:'btnview',width:'5%',columntype:'button'},
       				{ text: 'Fleet No',datafield:'fleet_no',width:'7%'},
       				{ text: 'Reg No',datafield:'reg_no',width:'6%'},
       				{ text: 'Plate Code',datafield:'platecode',width:'6%'},
       				{ text: 'Fleet Name',datafield:'flname',width:'12%',hidden:true},
       				{ text: 'Brand',datafield:'brand',width:'12%'},
       				{ text: 'Brand Id',datafield:'brandid',width:'12%',hidden:true},
       				{ text: 'Model',datafield:'model',width:'12%'},
       				{ text: 'Model Id',datafield:'modelid',width:'12%',hidden:true},
       				{ text: 'YOM',datafield:'yom',width:'6%'},
       				{ text: 'Out Date',datafield:'outdate',width:'7%',cellsformat:'dd.MM.yyyy'},
       				{ text: 'Out Time',datafield:'outtime',width:'6%',cellsformat:'HH:mm'},
       				{ text: 'Out Km',datafield:'outkm',width:'7%',cellsformat:'d2'},
       				{ text: 'Out Fuel',datafield:'outfuel',width:'6%'},
       				{ text: 'Description',datafield:'description',width:'12%'},
       				{ text: 'User',datafield:'user',width:'12%'},
       				{ text: 'User Id',datafield:'userid',width:'12%',hidden:true},
       				{ text: 'Driver',datafield:'driver',width:'12%'},
       				{ text: 'Driver Id',datafield:'driverid',width:'12%',hidden:true},
       				{ text: 'Fout',datafield:'fout',width:'12%',hidden:true},
       				{ text: 'Yomid',datafield:'yomid',width:'12%',hidden:true},
       				{ text: 'Chassis No',datafield:'chassisno',width:'12%',hidden:true},
       				{ text: 'InterCompany No',datafield:'compno',width:'12%',hidden:true}


					]
    });
    $('#ICgateInPassGrid').on('cellclick', function (event) 
    { 
  		var rowindex=event.args.rowindex;
  		var datafield=event.args.datafield;
      	$('#printdocno').val($('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'doc_no'));
      	if(datafield=="btnview"){
      		var user=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'user');
          	var description=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'description');
          	var brandid=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'brandid');
          	var modelid=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'modelid');
          	var km=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'outkm');
          	var fuel=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'fout');
          	var regno=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'reg_no');
          	var platecode=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'platecode');
          	var yomid=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'yomid');
          	var compno=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'compno');   
          	var url=document.URL;
    		var reurl=url.split("com/");
    		var movdocno=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
    		var chassisno=$('#ICgateInPassGrid').jqxGrid('getcellvalue',rowindex,'chassisno');
    		window.parent.formName.value="Gate In Pass";
    		window.parent.formCode.value="GIP";
    		var detName= "Gate In Pass";     
    		var path= "com/workshop/gateinpassalice/gateInPass.jsp?id=1&user="+user.replace(/ /g,"%20")+"&description="+description.replace(/ /g,"%20")+"&brandid="+brandid+"&modelid="+modelid+"&km="+km+"&fuel="+fuel+"&regno="+regno+"&platecode="+platecode.replace(/ /g,"%20")+"&yomid="+yomid+"&movdocno="+movdocno+"&chassisno="+chassisno+"&compno="+compno;
    		top.addTab( detName,reurl[0]+""+path);
      	}
      	
    });	 
     
  
    });

	
	
</script>
<div id="ICgateInPassGrid"></div>