 <%-- <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
<%@page import="com.operations.agreement.rentalagmtsayara.*"%>
<%String agmtno=request.getParameter("docnovals"); 
ClsRentalAgmtSayaraDAO agmtdao=new ClsRentalAgmtSayaraDAO();
%>
<script type="text/javascript">

$(document).ready(function () { 	
    var replacedata='<%=agmtdao.getReplacedVehicle(agmtno)%>';

    //var url="demo.txt"; 
	var num = 0;
    var source =
    {
        datatype: "json",
        datafields: [

                  	{name : 'ofleetno' , type: 'int' },
						{name : 'odate',type: 'date'},
						{name : 'otime',type: 'String'},
						{name : 'indate',type: 'date'},
						{name : 'intime',type: 'String'},
						{name : 'infleetno',type: 'int'},
						{name : 'repdoc',type: 'String'},
						{name : 'regnoin',type: 'String'},
						{name : 'regnoout',type: 'String'},
						//repdoc  regnoin regnoout
         ],
        localdata: replacedata,
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
    $("#vehReplaceGrid").jqxGrid(
    {
        width: '100%',
        height: 430,
        source: dataAdapter,
        columnsresize: true,
       // pageable: true,
        altRows: true,
        sortable: true,
        selectionmode: 'singlerow',
        //Add row method
        columns: [

                  { text: 'Doc NO', datafield: 'repdoc', width: '7%' },
                  { text: 'In Fleet', datafield: 'infleetno', width: '12%' },
                  { text: 'In Reg No', datafield: 'regnoin', width: '12%' },
					{ text: 'In Date', datafield: 'indate',width:'14%',cellsformat:'dd.MM.yyyy'},
					{ text: 'In Time', datafield: 'intime',width:'8%'},
					{ text: 'Out Fleet', datafield: 'ofleetno',width:'12%'},
					{ text: 'Out Reg No', datafield: 'regnoout',width:'12%'},
					{ text: 'Out Date', datafield: 'odate',width:'15%',cellsformat:'dd.MM.yyyy'},
					{ text: 'Out Time', datafield: 'otime',width:'8%'},
					
					
					//repdoc  regnoin regnoout
					
					
					
          ]
    });
    
    $("#popupWindow").jqxWindow({ width: 250, resizable: false,  isModal: true, autoOpen: false, cancelButton: $("#Cancel"), modalOpacity: 0.01 });
    // create context menu
       var contextMenu = $("#Menu").jqxMenu({ width: 200, height: 25, autoOpenPopup: false, mode: 'popup'});
       $("#vehReplaceGrid").on('contextmenu', function () {
           return false;
       });
       
       $("#Menu").on('itemclick', function (event) {
    	   var args = event.args;
           var rowindex = $("#vehReplaceGrid").jqxGrid('getselectedrowindex');
           if ($.trim($(args).text()) == "Edit Selected Row") {
               
           }
           else {
        	   var docno=$('#vehReplaceGrid').jqxGrid('getcellvalue',rowindex,'repdoc');
               var url=document.URL;
               var reurl=url.split("agreement");
               var branch=document.getElementById("brchName").value; 
               var win= window.open(reurl[0]+"vehicletransactions/replacement/printReplacements?docno="+docno,"_blank","top=250,left=310,Width=800,Height=800,location=no,scrollbars=no,toolbar=yes");
               win.focus();	 
               }
            
       });
       $("#vehReplaceGrid").on('rowclick', function (event) {
           if (event.args.rightclick) {
               $("#vehReplaceGrid").jqxGrid('selectrow', event.args.rowindex);
               var rowindex=event.args.rowindex;
               var scrollTop = $(window).scrollTop();
               var scrollLeft = $(window).scrollLeft();
               contextMenu.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + 5 + scrollLeft, parseInt(event.args.originalEvent.clientY) + 5 + scrollTop);
               return false;
           }
       });
});
</script>

<div id='jqxWidget'>
<div id="vehReplaceGrid"></div>
<div id="popupWindow">
		<div id='Menu'>
        <ul>
    		<li>Print</li>
		</ul>
		</div>
</div>
</div>

