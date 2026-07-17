<%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.operations.marketing.leasecostgroup.ClsleaseCostGroupDAO" %>
<%ClsleaseCostGroupDAO viewDAO= new ClsleaseCostGroupDAO(); %>
 
<script type="text/javascript">
var masterdatas='<%=viewDAO.searchMaster()%>';
   
        $(document).ready(function () {
 
 
        	

 
          
           var num = 0; 
          var source =
          {
          		
              datatype: "json",
              datafields: [

     	                  
                        	{name : 'doc_no' , type: 'number' },
                        	{name : 'date' , type: 'date' },
                         {name : 'gpname' , type: 'String' },
                        	{name : 'brdid' , type: 'String' },
                        	{name : 'brname' , type: 'String' },
                        	{name : 'modid' , type: 'String' },
                      	{name : 'modelname' , type: 'String' },
                      	 
                         {name : 'desc1' , type: 'String'}, 
                        {name : 'grpid' , type: 'String' },
                      	
                      //	doc_no, date, gpname, brdid, modid, brname, vtype, desc1
                        	
     						
                        	],
               localdata: masterdatas,
              
              
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
          $("#loaddatas").jqxGrid(
          {
              width: '100%',
              height: 360,
              source: dataAdapter,
              columnsresize: true,
              altRows: true,
              showfilterrow: true, 
              filterable: true, 
           
              selectionmode: 'singlerow',
          
           

              columns: [
                   
                      
     				{ text: 'Doc No',filtertype: 'number', datafield: 'doc_no', filterable: true, width: '10%'  },
     			 
     				{ text: 'Date',  columntype: 'textbox', filtertype: 'input',datafield: 'date', width: '15%',cellsformat:'dd.MM.yyyy' },
     			 
     				{ text: 'Group Name',columntype: 'textbox', filtertype: 'input', datafield: 'gpname', width: '25%' },
     				{ text: 'Brand', columntype: 'textbox', filtertype: 'input',datafield: 'brname', width: '25%' },
     				{ text: 'Model', columntype: 'textbox' ,filtertype: 'input',datafield: 'modelname', width: '25%'  },
     				{ text: 'desc1', columntype: 'textbox', filtertype: 'input',datafield: 'desc1', width: '20%',hidden:true },
     			 
     				{ text: 'brdid', datafield: 'brdid', width: '20%',hidden:true },
     				{ text: 'modid', datafield: 'modid', width: '20%',hidden:true },
     				{ text: 'grpid', datafield: 'grpid', width: '20%',hidden:true },
     				]
          });
          
        
          $('#loaddatas').on('rowdoubleclick', function (event) 
          		{ 
      	  var rowindex1=event.args.rowindex;
      	  if ($("#mode").val() != "A")
      		  {
        
        	$('#masterdate').jqxDateTimeInput({ disabled: false});
            $('#masterdate').val($("#loaddatas").jqxGrid('getcellvalue', rowindex1, "date")) ;
                   document.getElementById("docno").value=$('#loaddatas').jqxGrid('getcellvalue', rowindex1, "doc_no"); 
                   document.getElementById("groupname").value= $('#loaddatas').jqxGrid('getcellvalue', rowindex1, "gpname");
                   document.getElementById("brandname").value= $('#loaddatas').jqxGrid('getcellvalue', rowindex1, "brname");
                   
                   document.getElementById("modelname").value= $('#loaddatas').jqxGrid('getcellvalue', rowindex1, "modelname");
                            
                   document.getElementById("desc").value=$('#loaddatas').jqxGrid('getcellvalue', rowindex1, "desc1");
           
                   document.getElementById("brandid").value=$('#loaddatas').jqxGrid('getcellvalue', rowindex1, "brdid");
                   document.getElementById("modelid").value=$('#loaddatas').jqxGrid('getcellvalue', rowindex1, "modid");
                   document.getElementById("groupid").value=$('#loaddatas').jqxGrid('getcellvalue', rowindex1, "grpid");
                   $('#masterdate').jqxDateTimeInput({ disabled: true});
                
            
      
           
      		  }
           
          		 });	
          
          
          
           });
        </script>
        <div id="loaddatas"></div>    
           