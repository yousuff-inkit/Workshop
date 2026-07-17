<%@page import="com.dashboard.workshop.partsmanagement.*" %>
<%  CLSpartsManagementDAO partsdao=new CLSpartsManagementDAO();
/* String id=request.getParameter("id")==null?"0":request.getParameter("id");*/
String rowsno=request.getParameter("rowno")==null?"":request.getParameter("rowno"); 
String check=request.getParameter("check")==null?"":request.getParameter("check");
System.out.println("rowsno===="+rowsno);  
%>                    
<script type="text/javascript">
var data3;
var id='<%= check%>';
if(id!=0){    
	  data3='<%=partsdao. getSparePartData(rowsno)%>';	
}else{
	data3;
}
		     
$(document).ready(function () {
   
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [

                  		{name : 'description',type:'string'},
                  		{name : 'psrno',type:'number'},
                  		{name : 'rowno',type:'number'},
                  		{name : 'outqty',type:'number'},
                  		{name : 'partno',type:'number'},
                  		{name : 'partname',type:'string'},
                  		{name : 'qty',type:'number'},
                  		{name : 'total',type:'number'},
                  		{name : 'requested',type:'number'},
                  		{name : 'balance',type:'number'},
                  		{name : 'toberequested',type:'number'},
                  		{name : 'remarks',type:'string'},
                  		{name : 'specid',type:'string'},
                  		{name : 'unitdocno',type:'string'},
                  		{name : 'ordqty',type:'number'},
                  		{name : 'pivqty',type:'number'},
                  		{name : 'accno',type:'number'},
                  		{name : 'raccno',type:'number'},
                  		
                  		
                  		],
				    localdata: data3,
        
				   
    
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
    
    
     $("#jqxpartsgrid3").on("bindingcomplete", function (event) {
    	 	$("#overlay, #PleaseWait").hide();
	    	var rows=$("#jqxpartsgrid3").jqxGrid('getrows');
	    	for(var i=0;i<rows.length;i++){	    		
	    		var bvalue=$('#jqxpartsgrid3').jqxGrid('getcellvalue',i,'outqty');
	    		var qty=$('#jqxpartsgrid3').jqxGrid('getcellvalue',i,'qty');
	    		var purqty=$('#jqxpartsgrid3').jqxGrid('getcellvalue',i,'toberequested');
	    		if(bvalue==null || bvalue=="" || bvalue=="undefined" || typeof(bvalue)=="undefined"){
	    			
	    			$("#jqxpartsgrid3").jqxGrid('setcellvalue',i,'outqty', "0");
	    		}
	    		if(qty==null || qty=="" || qty=="undefined" || typeof(qty)=="undefined"){
	    			
	    			$("#jqxpartsgrid3").jqxGrid('setcellvalue',i,'qty', "0");
	    		}
               if(purqty==null || purqty=="" || purqty=="undefined" || typeof(purqty)=="undefined"){
	    			
	    			$("#jqxpartsgrid3").jqxGrid('setcellvalue',i,'toberequested', "0");
	    		}
	    		
	    		 var rqst=$('#jqxpartsgrid3').jqxGrid('getcellvalue',i,'outqty');	    		 
	    		 var bal=qty-rqst;
	    		 $("#jqxpartsgrid3").jqxGrid('setcellvalue',i,'balance',bal);
	    		 $("#jqxpartsgrid3").jqxGrid('setcellvalue',i,'toberequested',bal);
	    		
	    	}
    	
    	});        
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    
    $("#jqxpartsgrid3").jqxGrid(
    {
        width: '99%',
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
       				{ text: 'Parts',datafield:'description',editable:false},
       				{ text: 'Part No',datafield:'partno',editable:false,hidden:true},
       				{ text: 'Part Name', datafield:'partname',editable:false,hidden:true},
       				{ text: 'Qty',datafield:'qty',width:'10%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Purchased Qty',datafield:'outqty',width:'10%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Balance',datafield:'balance',width:'10%',editable:false,align:'right',cellsalign:'right',cellsformat:'d2'}, /* ,cellsalign:'right',cellsformat:'d2' */
       				{ text: 'To Be Purchased',datafield:'toberequested',editable:true,align:'right',cellsalign:'right',cellsformat:'d2'},
       				{ text: 'Pur Order Qty',datafield:'ordqty',align:'right',cellsalign:'right',cellsformat:'d2',hidden:true},
       				{ text: 'Pur Inv Qty',datafield:'pivqty',align:'right',cellsalign:'right',cellsformat:'d2',hidden:true},
       				{ text: 'Remarks',datafield:'remarks',editable:false,hidden:true},
       				{ text: 'Total',datafield:'total',cellsformat:'d2',hidden:true,editable:false},
       				{ text: 'Rowno',datafield:'rowno',editable:false,hidden:true},
       				{ text: 'mspecno',datafield:'specid',hidden:true},
       				{ text: 'unitdocno',datafield:'unitdocno',hidden:true},
       				{ text: 'psrno',datafield:'psrno',hidden:true},
       				{ text: 'accno',datafield:'accno',hidden:true},
       				{ text: 'raccno',datafield:'raccno',hidden:true},
					]
    });
    
    $('#jqxpartsgrid3').on('rowdoubleclick', function (event) 
      		{ 
    			
  	  		var rowindex1=event.args.rowindex;
  	  		/* $('#part').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"description"));
   	  	    $('#qnty').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"qty"));
   		    $('#price').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"total"));
   		    $('#rownum').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"rowno"));
   		    $('#purqty').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"requested"));
   		    $('#tbpur').val($('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex1,"toberequested")); */
      		});
    
    $("#jqxpartsgrid3").on("celldoubleclick", function (event) {
        var rowindex=event.args.rowindex;
        var dataField = event.args.datafield;
    	/* if(dataField=="partno"){
    		$('#partindex').val(rowindex);
    		$('#sparePartWindow').jqxWindow('open');
  			$('#sparePartWindow').jqxWindow('focus');
  			SearchContent('partNoSearch.jsp', 'sparePartWindow');
    	} */
    });
    
    $("#jqxpartsgrid3").on("cellvaluechanged", function (event) {
        var rowindex=event.args.rowindex;
        var dataField = event.args.datafield;
    	/*  if(dataField=="qty"){ 
    		 var rqst=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex,'requested');
    		 var qty=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex,'qty');
    		 var bal=qty-rqst;
    		 $("#jqxpartsgrid3").jqxGrid('setcellvalue',rowindex,'balance',bal);
    	}  */
    	 
    	 if(dataField=="toberequested"){ 
    		 var qnty=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex,'qty');
    		 var purchqty=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex,'toberequested');
    		 var bln=$('#jqxpartsgrid3').jqxGrid('getcellvalue',rowindex,'balance');
    		 if(bln==0){
    			 $.messager.alert('Warning','Not enough balance available');
    			 $('#jqxpartsgrid3').jqxGrid('setcellvalue',rowindex,'toberequested',"0");
    		 }
    		 /* $("#jqxpartsgrid3").jqxGrid('cellsformat',rowindex,'toberequested','d2'); */
    		/*  if(tbrqst>blnc){
    			 $.messager.alert('Warning','value should be less than balance');
    			 $("#jqxpartsgrid3").jqxGrid('setcellvalue',rowindex,'toberequested',"");	 
    		 } */
    		 //var bal=qnty-purchqty; 
    		 //$("#jqxpartsgrid3").jqxGrid('setcellvalue',rowindex,'balance',bal);
    		// $("#jqxpartsgrid3").jqxGrid('setcellvalue',rowindex,'requested',purchqty);
    		 
    	} 
    });    
      
});	

	
</script>
<div id="jqxpartsgrid3"></div>
<input type="hidden" name="partindex" id="partindex">