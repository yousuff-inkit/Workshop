 <%@page import="com.dashboard.marketing.onlinebookinglist.*" %>
 <%ClsOnlineBookingListDAO bookdao=new ClsOnlineBookingListDAO();
 String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
 String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
 String id=request.getParameter("id")==null?"0":request.getParameter("id");
 %>
<script type="text/javascript">
var bookdata=[];
var id='<%=id%>';
if(id=="1"){
	bookdata='<%=bookdao.getOnlineBookingList(fromdate, todate, id)%>';
}
$(document).ready(function () {
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [   
     
                     	{name : 'refname', type: 'String'  },
                        {name : 'bookdocno', type: 'number'  },
						{name : 'cldocno', type: 'number'  },
						{name : 'fromdate', type: 'date'  },
						{name : 'todate', type: 'date'  },
						{name : 'fromloc', type: 'String'  },
						{name : 'toloc', type: 'String'},
						{name : 'renttype', type: 'String'},
						{name : 'netamt', type: 'number'  },
						{name : 'fleetname',type:'string'},
						{name : 'tarifdocno',type:'number'}
						],
				    localdata: bookdata,
        
        
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
    
    
   
   
    
    $("#onlineBookingListGrid").jqxGrid(
    {
        width: '98%',
        height: 500,
        source: dataAdapter,
        showaggregates:true,
        enableAnimations: true,
        filtermode:'excel',
        filterable: true,
        sortable:true,
        selectionmode: 'singlerow',
        pagermode: 'default',
        editable:false,
        columns: [   
                  	 { text: 'SL#', sortable: false, filterable: false, editable: false,groupable: false, draggable: false, resizable: false,datafield: 'sl',
                  		 columntype: 'number', width: '5%',cellsrenderer: function (row, column, value) {
                         	return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
                     	}  
                     },
                     { text:'BookDocno',datafield:'bookdocno',width:'10%',hidden:true},
           	         { text: 'Client', datafield: 'refname',  width: '20%' },
           	         { text: 'Client Id',datafield:'cldocno',width:'10%',hidden:true},
           	      	 { text: 'Tarif Docno',datafield:'tarifdocno',width:'10%',hidden:true},
           	         { text: 'Vehicle',datafield:'fleetname',width:'17%'},
           	      	 { text: 'Rent Type',datafield: 'renttype', width: '8%' },
           	         { text: 'From date', datafield: 'fromdate', width: '8%',cellsformat:'dd.MM.yyyy'},
					 { text: 'To date', datafield: 'todate', width: '8%',cellsformat:'dd.MM.yyyy'},
				     { text: 'From Location',datafield: 'fromloc', width: '13%'},
				     { text: 'To Location',datafield: 'toloc', width: '13%' },
					 { text: 'Net Amount', datafield: 'netamt', width: '8%' ,cellsformat:'d2',align:'right',cellsalign:'right'}
					]
   
    });

  /*   $("#overlay, #PleaseWait").hide(); */
 		 $('#onlineBookingListGrid').on('rowdoubleclick', function (event) 
		{
	 		var rowindex=event.args.rowindex;
	 		document.getElementById("onlinebookdocno").value=$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'bookdocno');
	 		var details=document.getElementById("details").innerText;
	 		details+="Client  :"+$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'refname')+"\n";
	 		details+="Vehicle :"+$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'fleetname')+"\n";
	 		document.getElementById("details").innerText=details;
	 		document.getElementById("cldocno").value=$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'cldocno');
	 		$('#bookfromdate').jqxDateTimeInput('val',$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'fromdate'));
	 		$('#booktodate').jqxDateTimeInput('val',$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'todate'));
	 		document.getElementById("renttype").value=$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'renttype');
	 		document.getElementById("tarifdocno").value=$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'tarifdocno');
	 		document.getElementById("fleetname").value=$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'fleetname');
			document.getElementById("lblclient").innerText=$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'refname');
	 		document.getElementById("lblhidclient").innerText=$('#onlineBookingListGrid').jqxGrid('getcellvalue',rowindex,'cldocno');
 		}); 
});


</script>
<div id="onlineBookingListGrid"></div>