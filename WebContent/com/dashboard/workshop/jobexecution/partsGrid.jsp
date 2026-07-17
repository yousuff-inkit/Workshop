<%@page import="com.dashboard.workshop.jobexecution.*" %>
<% 
ClsJobExecutionDAO jedao=new ClsJobExecutionDAO(); 
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
%>
<script type="text/javascript">
 
var id='<%=id%>';
var data3;


if(id=='1'){
	  data3='<%=jedao.getSparePartData(docno, id)%>';	  
}

else{
data3=[];

}
 
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'description',type:'string'},
                  		{name : 'psrno',type:'number'},
                  		{name : 'partno',type:'number'},
                  		{name : 'partname',type:'string'},
                  		{name : 'qty',type:'number'},
                  		{name : 'requested',type:'number'},
                  		{name : 'balance',type:'number'},
                  		{name : 'toberequested',type:'number'},
                  		{name : 'remarks',type:'string'},
                  		{name : 'specid',type:'string'},
                  		{name : 'unitdocno',type:'string'},
                  		{name : 'ordqty',type:'number'},
                  		{name : 'pivqty',type:'number'},
                  		
                  		
                  		],
				    localdata: data3,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
    $("#partsgrid3").on("bindingcomplete", function (event) {
    	 	$("#overlay, #PleaseWait").hide();
	    	var rows=$("#partsgrid3").jqxGrid('getrows');
	    	for(var i=0;i<rows.length;i++){	    		
	    		var bvalue=$('#partsgrid3').jqxGrid('getcellvalue',i,'requested');
	    		var qty=$('#partsgrid3').jqxGrid('getcellvalue',i,'qty');
	    		if(bvalue==null || bvalue=="" || bvalue=="undefined" || typeof(bvalue)=="undefined"){
	    			
	    			$("#partsgrid3").jqxGrid('setcellvalue',i,'requested', "0");
	    		}
	    		if(qty==null || qty=="" || qty=="undefined" || typeof(qty)=="undefined"){
	    			
	    			$("#partsgrid3").jqxGrid('setcellvalue',i,'qty', "0");
	    		}
	    		
	    		 var rqst=$('#partsgrid3').jqxGrid('getcellvalue',i,'requested');	    		 
	    		 var bal=qty-rqst;
	    		 $("#partsgrid3").jqxGrid('setcellvalue',i,'balance',bal);
	    		
	    	}
    	
    	});        
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#partsgrid3").jqxGrid(
    {
        width: '98%',
        height: 200,
        columnsheight:23,
        source: dataAdapter,
        filtermode:'excel',
        filterable: true,
        editable:true,
        selectionmode: 'singlecell',
        selectionmode: 'checkbox',
       sortable:false,
        columns: [
					
					{ text: 'Sr. No', sortable: false, filterable: false, editable: false,
             groupable: false, draggable: false, resizable: false,datafield: '',
             columntype: 'number', width: '5%',cellsalign: 'center', align: 'center',
             cellsrenderer: function (row, column, value) {
              return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
           					}    
       				},
       				{ text: 'Description',datafield:'description',width:'15%',editable:false},
       				{ text: 'Part No',datafield:'partno',width:'7%',editable:false},
       				{ text: 'Part Name', datafield:'partname',width:'15%',editable:false},
       				{ text: 'Qty',datafield:'qty',width:'5%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Requested',datafield:'requested',width:'6%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Balance',datafield:'balance',width:'5%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'}, /* ,cellsalign:'right',cellsformat:'d2' */
       				{ text: 'To Be Requested',datafield:'toberequested',width:'9%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Pur Order Qty',datafield:'ordqty',width:'8%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Pur Inv Qty',datafield:'pivqty',width:'7%',align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Remarks',datafield:'remarks',width:'15%',editable:false,},
       				{ text: 'mspecno',datafield:'specid',width:'15%',hidden:true},
       				{ text: 'unitdocno',datafield:'unitdocno',width:'15%',hidden:true},
       				{ text: 'psrno',datafield:'psrno',width:'15%',hidden:true}
  

					]
    });
    $('#partsgrid3').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  			var rowindex1=event.args.rowindex;
  	  			

      		});
    
    $("#partsgrid3").on("celldoubleclick", function (event) {
        var rowindex=event.args.rowindex;
        var dataField = event.args.datafield;
    	/* if(dataField=="partno"){
    		$('#partindex').val(rowindex);
    		$('#sparePartWindow').jqxWindow('open');
  			$('#sparePartWindow').jqxWindow('focus');
  			SearchContent('partNoSearch.jsp', 'sparePartWindow');
    	} */
    });
    
    $("#partsgrid3").on("cellvaluechanged", function (event) {
        var rowindex=event.args.rowindex;
        var dataField = event.args.datafield;
    	/*  if(dataField=="qty"){ 
    		 var rqst=$('#partsgrid3').jqxGrid('getcellvalue',rowindex,'requested');
    		 var qty=$('#partsgrid3').jqxGrid('getcellvalue',rowindex,'qty');
    		 var bal=qty-rqst;
    		 $("#partsgrid3").jqxGrid('setcellvalue',rowindex,'balance',bal);
    	}  */
    	 
    	 if(dataField=="toberequested"){ 
    		 var blnc=$('#partsgrid3').jqxGrid('getcellvalue',rowindex,'balance');
    		 var tbrqst=$('#partsgrid3').jqxGrid('getcellvalue',rowindex,'toberequested');
    		 /* $("#partsgrid3").jqxGrid('cellsformat',rowindex,'toberequested','d2'); */
    		 if(tbrqst>blnc){
    			 $.messager.alert('Warning','value should be less than balance');
    			 $("#partsgrid3").jqxGrid('setcellvalue',rowindex,'toberequested',"");	 
    		 }
    	} 
    });
      
});	

	
</script>
<div id="partsgrid3"></div>
<input type="hidden" name="partindex" id="partindex">