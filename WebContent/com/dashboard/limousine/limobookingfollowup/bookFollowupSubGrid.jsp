<%@page import="com.dashboard.limousine.limobookingfollowup.*" %>
<%ClsLimoBookFollowupDAO followdao=new ClsLimoBookFollowupDAO(); 
String branch=request.getParameter("branch")==null?"0":request.getParameter("branch");
String id=request.getParameter("id")==null?"0":request.getParameter("id");
String bookdocno=request.getParameter("bookdocno")==null?"":request.getParameter("bookdocno");
%>
<script type="text/javascript">
var followupsubdata;
var BookFollowuprexcel;
var id='<%=id%>';
if(id=="1"){
	followupsubdata='<%=followdao.getFollowupDetailData(bookdocno,id)%>';
        BookFollowuprexcel='<%=followdao.excelFollowupsubData(branch,id)%>';
}
$(document).ready(function () {

    // prepare the data
    var source =
    {
        datatype: "json",
        datafields: [
						{name : 'doc_no' , type: 'int' },
						{name : 'bookdocno',type:'int'},
						{name : 'detaildocno',type:'int'},
						{name : 'docname',type:'string'},
						{name : 'type',type:'string'},
						{name : 'blockhrs',type:'number'},
						{name : 'pickupdate',type:'date'},
						{name : 'pickuptime',type:'date'},
						{name : 'pickuplocation',type:'string'},
						{name : 'pickupaddress',type:'string'},
						{name : 'dropofflocation',type:'string'},
						{name : 'dropoffaddress',type:'string'},
						{name : 'brand',type:'string'},
						{name : 'model',type:'string'},
						{name : 'nos',type:'string'},
						{name : 'brandid',type:'string'},
						{name : 'modelid',type:'string'}
						
						],
				    localdata: followupsubdata,
        
        
        pager: function (pagenum, pagesize, oldpagenum) {
            // callback called when a page or page size is changed.
        }
    };
         
          $('#bookFollowupSubGrid').on('bindingcomplete', function (event) {

          });
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
		            
	            }		
    );
    
    
    $("#bookFollowupSubGrid").jqxGrid(
    {
        width: '98%',
        height: 200,
        source: dataAdapter,
        showaggregates:true,
        showstatusbar:true,
        statusbarheight: 25,
        filtermode:'excel',
        filterable: true,
        selectionmode: 'checkbox',
        columns: [
                  
							{ text: 'Doc No', datafield: 'doc_no',width:'4%',hidden:true},
							{ text: 'Detail Docno',datafield:'detaildocno',width:'4%',hidden:true},
							{ text: 'Booking Docno',datafield: 'bookdocno',width:'4%',hidden:true},
							{ text: 'Job Name',datafield:'docname',width:'4.5%'},
							{ text: 'Type',datafield:'type',width:'8%'},
							{ text: 'Block Hrs',datafield:'blockhrs',width:'6%'},
							{ text: 'Pickup date',datafield:'pickupdate',width:'8%',cellsformat:'dd.MM.yyyy'},
							{ text: 'Pickup time',datafield:'pickuptime',width:'7%',cellsformat:'HH:mm'},
							{ text: 'Pickup Location',datafield:'pickuplocation',width:'10%'},
							{ text: 'Pickup Address',datafield: 'pickupaddress',width:'10%'},
							{ text: 'Dropoff Location',datafield:'dropofflocation',width:'10%'},
							{ text: 'Dropoff Address',datafield:'dropoffaddress',width:'10%'},
							{ text: 'Brand',datafield:'brand',width:'10%'},
							{ text: 'Model',datafield:'model',width:'9.5%'},
							{ text: 'Nos',datafield:'nos',width:'4%'},
							{ text: 'Brandid',datafield:'brandid',width:'4%',hidden:true},
							{ text: 'Modelid',datafield:'modelid',width:'4%',hidden:true}

					]

    });

    $('#bookFollowupSubGrid').on('rowdoubleclick', function (event) 
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
    		    /* 
    		    document.getElementById("bookdocno").value=$('#bookFollowupGrid').jqxGrid('getcellvalue',boundIndex,'doc_no');
    		    $('#followupdetaildiv').load('followupDetailGrid.jsp?bookdocno='+document.getElementById("bookdocno").value+'&id=1'); */
    		});
});

	
	
</script>
<div id="bookFollowupSubGrid"></div>