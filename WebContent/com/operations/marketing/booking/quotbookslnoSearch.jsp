<%@page import="com.operations.marketing.booking.ClsbookingDAO" %>
 
  <%         
	String qrdocno = request.getParameter("qrdocno")==null?"NA":request.getParameter("qrdocno").trim().toString();
  ClsbookingDAO viewDAO=new ClsbookingDAO();
           	  %>  
 
<%-- 
 <jsp:include page="../../../../includes.jsp"></jsp:include> --%>
 <script type="text/javascript">
 
 
  var temp='<%=qrdocno%>';
  
  

 if(temp!='NA')
	 {
	 
	 var qutslnodata='<%=viewDAO.slnosearch(qrdocno)%>'; 
	 }
 else
	 {
	 var qutslnodata="";
	 } 
  




  $(document).ready(function () { 	
     
      var num = 0; 
     var source =
     {
     		
         datatype: "json",
         datafields: [
                      

                      
                   	{name : 'sr_no' , type: 'number' },
                    {name : 'brdid' , type: 'String' },
                   	{name : 'brand' , type: 'String' },
                   	{name : 'modid' , type: 'String' },
                   	{name : 'model' , type: 'String' },
                 	{name : 'specification' , type: 'String' },
                 	{name : 'color' , type: 'String' },
                 	{name : 'clrid' , type: 'String'} ,
                    {name : 'unit' , type: 'String'} ,
                    {name : 'fromdate' , type: 'String'} ,
                	{name : 'todate' , type: 'String' },
                 	{name : 'hidfromdate' , type: 'String'} ,
                    {name : 'hidtodate' , type: 'String'} ,
                    {name : 'renttype' , type: 'String'},
                    {name : 'grpid' , type: 'String'} ,
                	{name : 'gname' , type: 'String' },
                	{name : 'tdocno' , type: 'String' }
                    
                    
						
                   	],
          localdata: qutslnodata,
         
         
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
     $("#qutslsearch").jqxGrid(
     {
         width: '100%',
         height: 280,
         source: dataAdapter,
         columnsresize: true,
        // pageable: true,
         altRows: true,
         filterable: true,
         showfilterrow: true,
         selectionmode: 'singlerow',
         pagermode: 'default',
        // sortable: true,
         //Add row method

         columns: [
             
                 
				{ text: 'SL No', datafield: 'sr_no', width: '7%' },
				{ text: 'Brand', datafield: 'brand', width: '27%' },
				{ text: 'Brid', datafield: 'brdid', width: '10%',hidden:true },
				{ text: 'Model', datafield: 'model', width: '22%' },
				{ text: 'modid', datafield: 'modid', width: '10%',hidden:true  },
				{ text: 'specification', datafield: 'specification', width: '10%',hidden:true  },
				{ text: 'Color', datafield: 'color', width: '15%' },
				{ text: 'clrid', datafield: 'clrid', width: '10%',hidden:true  },
				{ text: 'unit', datafield: 'unit', width: '10%' ,hidden:true },
				{ text: 'grpid', datafield: 'grpid', width: '5%',hidden:true  },
				{ text: 'Group', datafield: 'gname', width: '10%' },
				{ text: 'Rental Type', datafield: 'renttype', width: '19%' },
				{ text: 'tdocno', datafield: 'tdocno', width: '19%',hidden:true }
				
				]
     });
    
     
     $('#qutslsearch').on('rowdoubleclick', function (event) 
     		{ 
 	  var rowindex1=event.args.rowindex;
 	var indexrdocno=document.getElementById("refqouteno").value;
 	var qotslno=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "sr_no");
 	 var groupid=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "grpid");
 
     document.getElementById("tarifdoc").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "tdocno");
 	$("#tariffDivId").load('bookingrentalgrid.jsp?indexrdocno='+indexrdocno+'&qotslno='+qotslno+'&groupid='+groupid);
 	
 	
 	 
 	  document.getElementById("bookslno").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "sr_no");
      document.getElementById("bookbrand").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "brand");
     document.getElementById("bookbrandid").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "brdid");
     
     document.getElementById("bookmodel").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "model");
     document.getElementById("bookmodelid").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "modid");
     
     document.getElementById("bookcolor").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "color");
     document.getElementById("bookcolorid").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "clrid");
     
     
     document.getElementById("bookgroup").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "gname");
     document.getElementById("bookgroupid").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "grpid");
      
     document.getElementById("renttype").value=$('#qutslsearch').jqxGrid('getcellvalue', rowindex1, "renttype");
     
     var aa="excessinsur";
     funRoundAmt(0,aa);
     $('#excessinsur').attr("readonly" ,false);
     $('#bookqutslnosearch').jqxWindow('close');
     		 });	 
     
 });
</script>
<div id="qutslsearch"></div>
