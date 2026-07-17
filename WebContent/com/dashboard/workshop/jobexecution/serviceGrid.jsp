<%@page import="com.dashboard.workshop.jobexecution.*" %>
<% 
ClsJobExecutionDAO jedao=new ClsJobExecutionDAO(); 
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
%>
<script type="text/javascript">
 
var id='<%=id%>';
var data2;


if(id=='1'){
	  data2='<%=jedao.getServiceData(docno, id)%>'; 
	  
}
else{
data2=[];

}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'servicetype',type:'string'},
                  		{name : 'description',type:'string'},
                  		{name : 'remarks',type:'string'},
                  		{name : 'completed',type:'string'},
                  		{name : 'execdetails',type:'string'},
                  		{name : 'technician',type:'string'},
                  		{name : 'bay',type:'string'},
                  		{name : 'rowno',type:'number'},
                  		{name : 'bayno',type:'number'},
                  		{name : 'techno',type:'number'},
                  		
                  		],
				    localdata: data2,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#servicegrid2").on("bindingcomplete", function (event) {
    	$("#overlay, #PleaseWait").hide();
    	});        
    
    
    var dropdownListSource=['Yes','No'];
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#servicegrid2").jqxGrid(
    {
        width: '98%',
        height: 200,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        editable:true,
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
					//{ text: 'Check',datafield:'check',width:'5%',columntype:'checkbox',editable: true, resizable: false},
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '4%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Service Type',datafield:'servicetype',width:'13%',editable:false,},
       				{ text: 'Description',datafield:'description',width:'17%',editable:false,},
       				{ text: 'Remarks', datafield:'remarks',width:'17%',editable:false,},
       				{ text: 'Technician',datafield:'technician',width:'10%',editable:false},
       				{ text: 'Bay',datafield:'bay',width:'10%',editable:false},
       				{ text: 'Complete',columntype: 'dropdownlist',datafield: 'completed', width: '6%',editable:true,
						initeditor: function (row, cellvalue, editor) {
	                          editor.jqxDropDownList({ source: dropdownListSource});
	                      }},
       				{ text: 'Execution Details',datafield:'execdetails',width:'20%',},
	                { text: 'rowno',datafield:'rowno',width:'5%',hidden:true},
       				{ text: 'techno',datafield:'techno',width:'5%',hidden:true},
       				{ text: 'bayno',datafield:'bayno',width:'5%',hidden:true}

					]
    });
    $('#servicegrid2').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
  	  			

      		});
    $("#servicegrid2").on("celldoubleclick", function (event) {
        var rowindex=event.args.rowindex;
        var dataField = event.args.datafield;
    	if(dataField=="technician"){
    		$('#techindex').val(rowindex);
    		$('#TechnicianWindow').jqxWindow('open');
  			$('#TechnicianWindow').jqxWindow('focus');
  			SearchContent('technicianSearch.jsp', 'TechnicianWindow');
    	}
    	if(dataField=="bay"){
    		$('#techindex').val(rowindex);
    		$('#bayWindow').jqxWindow('open');
  			$('#bayWindow').jqxWindow('focus');
  			SearchContent('baySearch.jsp', 'bayWindow');
    	}
    	
    });
});	

	
</script>
<div id="servicegrid2"></div>
<input type="hidden" name="techindex" id="techindex">
