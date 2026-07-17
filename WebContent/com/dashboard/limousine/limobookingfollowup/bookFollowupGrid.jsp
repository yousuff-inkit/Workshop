<%@page import="com.dashboard.limousine.limobookingfollowup.*" %>
<%ClsLimoBookFollowupDAO followdao=new ClsLimoBookFollowupDAO(); 
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String fromdate=request.getParameter("fromdate")==null?"":request.getParameter("fromdate");
String todate=request.getParameter("todate")==null?"":request.getParameter("todate");
%>
<script type="text/javascript">
var followupdata;
var BookFollowuprexcel;
var id='<%=id%>';
if(id=="1"){
	followupdata='<%=followdao.getFollowupData(branch,id,fromdate,todate)%>';
        BookFollowuprexcel='<%=followdao.excelFollowupData(branch,id,fromdate,todate)%>';
}
$(document).ready(function () {
	  
    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
                      	{name : 'doc_no' , type: 'string' },
                  		{name : 'date' , type: 'date' },
						{name : 'client', type: 'String'  },
						{name : 'guest', type: 'String'  },
						{name : 'contactno', type: 'string'  },
						{name : 'transfercount', type: 'number'  },
						{name : 'hourscount', type: 'number'  },
						{name : 'srvccount', type: 'number'  }
						
						],
				    localdata: followupdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
         
          $('#bookFollowupGrid').on('bindingcomplete', function (event) {

          });
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#bookFollowupGrid").jqxGrid(
    {
        width: '98%',
        height: 400,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
       sortable:true,
        columns: [
                  
					{ text: 'SL#', sortable: false, filterable: false, editable: false,
					    groupable: false, draggable: false, resizable: false,
					    datafield: 'sl', columntype: 'number', width: '3%',
					    cellsrenderer: function (row, column, value) {
					        return "<center><div style='margin:4px;'>" + (value + 1) + "</div></center>";
					    }  
					  },
                        { text: 'Doc No', datafield: 'doc_no', width: '7%'},  
      					{ text: 'Date', datafield: 'date', width: '8%',cellsformat:'dd.MM.yyyy'},
						{ text: 'Client', datafield: 'client', width: '20%'},
						{ text: 'Guest', datafield: 'guest', width: '20%'},
						{ text: 'Contact No', datafield: 'contactno', width: '12%'},
						{ text: 'Transfer', datafield: 'transfercount', width: '10%'},
						{ text: 'Limo', datafield: 'hourscount', width: '10%'},
						{ text: 'Extra Services', datafield: 'srvccount', width: '10%'}

					]

    });

    $('#bookFollowupGrid').on('rowdoubleclick', function (event) 
    		{ 
    		    var args = event.args;
    		    // row's bound index.
    		    var boundIndex = event.args.rowindex;
    		    // row's visible index.
    		    var visibleIndex = event.args.visibleindex;
    		    // right click.
    		    var rightclick = event.args.rightclick; 
    		    // original event.
    		    var ev = event.args.originalEvent;
    		    
    		    document.getElementById("bookdocno").value=$('#bookFollowupGrid').jqxGrid('getcellvalue',boundIndex,'doc_no');
    		    $('#followupdetaildiv').load('followupDetailGrid.jsp?bookdocno='+document.getElementById("bookdocno").value+'&id=1');
    		});
    
    
    $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
       var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
       $("#bookFollowupGrid").on('contextmenu', function () {
           return false;
       });
      
       $("#Menu").on('itemclick', function (event) {
    	   var args = event.args;
    	   
    	 var aa=document.getElementById("setdata").value;
    	   if(parseInt(aa)==2)
    		   {
           var rowindex = $("#bookFollowupGrid").jqxGrid('getselectedrowindex');
           if ($.trim($(args).text()) == "View Booking") {
			
        	  var docno=$('#bookFollowupGrid').jqxGrid('getcellvalue',rowindex,'doc_no');
       		  var url=document.URL;
       		  var reurl=url.split("com");
       		  /* window.parent.formName.value="Limousine Booking";
       		  window.parent.formCode.value="LBK";  */
       		  var detName= "Limousine Booking";
       		  var path= "com/limousine/booking/limoBooking.jsp?mode=view&tempdocno="+docno+"&detailmode=1";
       		  
       		  top.addTab(detName,reurl[0]+""+path);
       		  
       		  document.getElementById("setdata").value="1";
           }
           document.getElementById("setdata").value="1";
           }

       });
       $("#bookFollowupGrid").on('rowclick', function (event) {
           if (event.args.rightclick){
        	   document.getElementById("setdata").value="2";
               $("#bookFollowupGrid").jqxGrid('selectrow', event.args.rowindex);
               var scrollTop = $(window).scrollTop();
               var scrollLeft = $(window).scrollLeft();
               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               return false;
           
		   }
       });

    
});

	
	
</script>
<div id='jqxWidget'>
    <div id="bookFollowupGrid"></div>
    <div id="popupWindow">
 <div id='Menu'>
        <ul>
            <li>View Booking</li>
        </ul>
        
        <input type="hidden" id="setdata" value="2">
       </div>
       </div>
       </div>
