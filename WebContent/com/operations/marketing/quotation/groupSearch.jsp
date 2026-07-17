
	<%
			String  barnds=request.getParameter("branddoc")==null?"0":request.getParameter("branddoc");

	String  models=request.getParameter("modeldoc")==null?"0":request.getParameter("modeldoc");

	
			%>
			
 <%@page import="com.operations.marketing.quotation.ClsquotationDAO" %>

<%

ClsquotationDAO viewDAO=new ClsquotationDAO();

%>

       <script type="text/javascript">
  
  	 var groupdata= '<%=viewDAO.searchGroup(barnds,models) %>';

		$(document).ready(function () { 	
        	/* var url=""; */
        	
           
           
            var source =
            {
                datatype: "json",
                datafields: [
                            
                            {name : 'gname', type: 'string'  },
                            {name : 'doc_no', type: 'string'  }
     						
                        ],
                		
                		//  url: url1,
                 localdata: groupdata,
                
                pager: function (pagenum, pagesize, oldpagenum) {
                    // callback called when a page or page size is changed.
                }
                                        
            };
         
            var dataAdapter = new $.jqx.dataAdapter(source);
            
            $("#quotgroupSearch").jqxGrid(
            {
                width: '100%',
                height: 330,
                source: dataAdapter,
                columnsresize: true,
                altRows: true,
                showfilterrow: true, 
                filterable: true, 
             
                selectionmode: 'singlerow',
            
                
            
                       
                columns: [
							
							 
                          
                              { text: 'DOC NO', datafield: 'doc_no', width: '20%',hidden:true},
                              { text: 'GROUP', datafield: 'gname', width: '100%' }
                           
						
						
	             
						]
            });
            
          $('#quotgroupSearch').on('rowdoubleclick', function (event) {
            	var rowindex1 =$('#rowindex').val();
                var rowindex2 = event.args.rowindex;
                //alert("rowindex1"+rowindex1);
               // alert("rowindex2"+rowindex2);
               document.getElementById("tacalrowindex").value = rowindex1; 
        		var indexVal7 = $('#quotgroupSearch').jqxGrid('getcellvalue', rowindex2, "doc_no");
                var vehGroup=$('#quotgroupSearch').jqxGrid('getcellvalue', rowindex2, "gname");
                $('#qutgrid').jqxGrid('setcellvalue', rowindex1, "gname" ,vehGroup);
                $('#qutgrid').jqxGrid('setcellvalue', rowindex1, "grpid" ,indexVal7);
           	 $('#tarifcalGrid').jqxGrid('setcellvalue',rowindex1 , "group1",vehGroup);
			 $('#tarifcalGrid').jqxGrid('setcellvalue',rowindex1 , "grpid",indexVal7);
			 var val="";
			 $("#tarifcalGrid").jqxGrid('setcellvalue', rowindex1, "rentaltype", val);
			 $("#tarifcalGrid").jqxGrid('setcellvalue', rowindex1, "rate", val);
	     	  $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"cdw",val);
			 $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"pai",val);
			   $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"cdw1",val);
			  $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"pai1",val);
			    $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"gps",val);
			   $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"babyseater",val);
			   $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"cooler",val);
			  $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"kmrest",val);
			  $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"exkmrte",val);
			   $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"oinschg",val);
			  $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1,"exhrchg",val);
			  $('#tarifcalGrid').jqxGrid('setcellvalue', rowindex1, "tdocno",val);
			  
			  document.getElementById("tarigrpid").value = indexVal7;
			  if($('#mode').val()=="A")
				  {
			  
			  $("#tarifDivId").load("tarifGrid.jsp");
			  
				  }
              var rows = $('#qutgrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1==rowlength-1)
                {
                	$("#qutgrid").jqxGrid('addrow', null, {});
                }
                
                var rows = $('#tarifcalGrid').jqxGrid('getrows');
                var rowlength= rows.length;
                if(rowindex1==rowlength-1)
                {
                	 $("#tarifcalGrid").jqxGrid('addrow', null,  {});
                }
                
                
              $('#groupsearchwndows').jqxWindow('close'); 
            }); 
        });
    </script>
    <div id="quotgroupSearch"></div> 