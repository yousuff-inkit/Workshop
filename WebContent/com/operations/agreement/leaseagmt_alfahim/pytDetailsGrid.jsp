<%@page import="com.operations.agreement.leaseagmt_alfahim.*"%>
<%ClsLeaseAgmtAlFahimDAO leasedao=new ClsLeaseAgmtAlFahimDAO(); %>
<%String docno=request.getParameter("docno")==null?"":request.getParameter("docno");
String pytstartdate=request.getParameter("pytstartdate")==null?"":request.getParameter("pytstartdate");
String pytadvance=request.getParameter("pytadvance")==null?"":request.getParameter("pytadvance");
String pytbalance=request.getParameter("pytbalance")==null?"":request.getParameter("pytbalance");
String pytmonthno=request.getParameter("pytmonthno")==null?"":request.getParameter("pytmonthno");
String id=request.getParameter("id")==null?"":request.getParameter("id");
%>
<script>
var pytdetaildata;
var id='<%=id%>';
if(id=="1"){
	pytdetaildata='<%=leasedao.getPytProcessData(docno,pytstartdate,pytadvance,pytbalance,pytmonthno,id)%>';
}
else if(id=="2"){
	 pytdetaildata='<%=leasedao.getChequeData(docno,id)%>';
}

$(document).ready(function(){
	
	var rendererstring=function (aggregates){
    	var value=aggregates['sum'];
    	return '<div style="float: right; margin: 4px;font-size:12px; overflow: hidden;">' + "" + value + '</div>';
    }
    var source =
    {
        datatype: "json",
        datafields: [                          	
                    	{name : 'date', type: 'date'  },
						{name : 'amount', type: 'number'    },
						{name : 'bpvno', type: 'string'    },
						{name : 'chequeno', type: 'string'    },
						{name : 'detaildocno',type:'number'}
						
						
						
         ],               
         localdata: pytdetaildata,
        
         deleterow: function (rowid, commit) {
             // synchronize with the server - send delete command
             // call commit with parameter true if the synchronization with the server is successful 
             // and with parameter false if the synchronization failed.
             commit(true);
         },
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
                                
    };
    
    $("#pytDetailsGrid").on("bindingcomplete", function (event) {
    	// your code here.
    
    	var rows=$('#pytDetailsGrid').jqxGrid('getrows');
    	
    	for(var i=0;i<rows.length;i++){
    		var reciept=$('#pytDetailsGrid').jqxGrid('getcellvalue',i,'bpvno');
    		if(reciept!="undefined" && reciept!=null && reciept!="" && typeof(reciept)!="undefined"){
    			$('#pytDetailsGrid').jqxGrid('selectrow', i);
    		}
    	}
    });
    
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
	            
            }
    );
   
    
    
    $("#pytDetailsGrid").jqxGrid(
    {
        width: '100%',
        height: 150,
        source: dataAdapter,
        editable:true,
        altRows: true,
        selectionmode: 'checkbox',
        showaggregates:true,
        showstatusbar:true,
                  
        
       
      /*   handlekeyboardnavigation: function (event) {
        	
            var cell1 = $('#jqxgrid2').jqxGrid('getselectedcell');
          alert(cell1);
            if (cell1 != undefined && cell1.datafield == 'name1') {
            	
                var key = event.charCode ? event.charCode : event.keyCode ? event.keyCode : 0; 
                alert("asss"+key);
                if (key == 114) {                                                      
                	driverinfoSearchContent('clientDriverSearch.jsp');
                 }
            } 
            
        }, 
        */
        
        columns: [
                    { text: 'SL#', sortable: false, filterable: false, editable: false,
                      groupable: false, draggable: false, resizable: false,
                      datafield: '', columntype: 'number', width: '4%',
                      cellsrenderer: function (row, column, value) {
                          return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                      }  
                    },							
					{ text: 'Date', datafield: 'date', width: '24%',cellsformat: 'dd.MM.yyyy', editable: true,columntype:'datetimeinput' },
					{ text: 'Amount',datafield:'amount',width:'24%',cellsformat:'d2',cellsalign:'right',align:'right', editable: true,aggregates: ['sum'],aggregatesrenderer:rendererstring},
					{ text: 'Cheque No', datafield: 'chequeno', width: '24%'},
					{ text: 'Reciept No', datafield: 'bpvno', width: '21.5%', editable: false},
					{ text: 'Detail Docno',datafield:'detaildocno',width:'10%',hidden:true}
					
          ]
    });
  

    $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
       var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
       $("#pytDetailsGrid").on('contextmenu', function () {
           return false;
       });
	
    
       $("#Menu").on('itemclick', function (event) {
    	   var args = event.args;
           var rowindex = $("#pytDetailsGrid").jqxGrid('getselectedrowindex');
           if ($.trim($(args).text()) == "Edit Selected Row") {
               editrow = rowindex;
               var offset = $("#pytDetailsGrid").offset();
               $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 60} });
               // get the clicked row's data and initialize the input fields.
               var dataRecord = $("#pytDetailsGrid").jqxGrid('getrowdata', editrow);
               // show the popup window.
               $("#popupWindow").jqxWindow('show');
           }
           else {
               var rowid = $("#pytDetailsGrid").jqxGrid('getrowid', rowindex);
               $("#pytDetailsGrid").jqxGrid('deleterow', rowid);
           }
       });
	   
       $("#pytDetailsGrid").on('rowclick', function (event) {
           if (event.args.rightclick) {
		   //if(document.getElementById("mode").value=="A" || document.getElementById("mode").value=="E"){
               $("#pytDetailsGrid").jqxGrid('selectrow', event.args.rowindex);
               var scrollTop = $(window).scrollTop();
               var scrollLeft = $(window).scrollLeft();
               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               return false;
           //}
		   }
       });
       
});
</script>
<div id='jqxWidget'>
	<div id="pytDetailsGrid"></div>
    <div id="popupWindow">
 		<div id='Menu'>
        	<ul>
            	<li>Delete Selected Row</li>
        	</ul>
       	</div>
    </div>
</div>
