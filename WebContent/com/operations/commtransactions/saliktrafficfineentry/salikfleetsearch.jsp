<%@page import="com.operations.commtransactions.saliktrafficfineentry.ClsSaliktrafficDAO" %>
<% ClsSaliktrafficDAO cstd = new ClsSaliktrafficDAO();%>
 
 
 <%@page import="javax.servlet.http.HttpServletRequest" %>
<%@page import="javax.servlet.http.HttpSession" %>
 
 <script type="text/javascript">
 var salickfleet='<%=cstd.saliksearchfleet(session)%>';
 $(document).ready(function () { 	
     
     var num = 0; 
    var source = 
    {
        datatype: "json",
        datafields: [

						{name : 'reg_no', type: 'String'  },
						{name : 'fleet_no', type: 'String'  },
						{name : 'tcno', type: 'String'  },
						{name : 'flname', type: 'String'  }
				                        	
                  	],
     
                  	localdata: salickfleet,
        
        pager: function (pagenum, pagesize, oldpagenum) {
           
        }
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source,
    		 {
        		loadError: function (xhr, status, error) {
                alert(error);    
                }
            }		
    );
    $("#salickfleetSearch").jqxGrid(
    {
        width: '99.9%',
        height: 330,
        source: dataAdapter,
    
        filterable: true,
        showfilterrow: true,
        selectionmode: 'singlerow',
        pagermode: 'default',
      
        //Add row method

        columns: [

			{ text: 'FLEET', datafield: 'fleet_no', width: '17%' },
			{ text: 'NAME', datafield: 'flname', width: '65%'  },
			{ text: 'Reg NO', datafield: 'reg_no', width: '18%' },
			{ text: 'Tag NO', datafield: 'tcno', width: '15%',hidden:true },
	
		/* 	{ text: 'COLOR', datafield: 'color', width: '17%', cellsalign: 'center', align:'center' },
			{ text: 'GROUP', datafield: 'gname', width: '18%', cellsalign: 'center', align:'center' },
			{ text: 'Location', datafield: 'a_loc', width: '15%',hidden:true},
			{ text: 'GID', datafield: 'gid', width: '15%',hidden:true},
			{ text: 'KM', datafield: 'kmin', width: '15%',hidden:true},
			 { text: 'FUEL', datafield: 'fin', width: '15%',hidden:true}, */
			
			]
    });
    
    $('#salickfleetSearch').on('rowdoubleclick', function (event) 
    		{ 
    
    	  var rowBoundIndex = event.args.rowindex;
    	
    	  var rowindex3 =$('#rowindex1').val();
    
          $('#salikgrid').jqxGrid('setcellvalue', rowindex3, "fleetno" ,$('#salickfleetSearch').jqxGrid('getcellvalue', rowBoundIndex, "fleet_no"));
          $('#salikgrid').jqxGrid('setcellvalue', rowindex3, "regno" ,$('#salickfleetSearch').jqxGrid('getcellvalue', rowBoundIndex, "reg_no"));
          $('#salikgrid').jqxGrid('setcellvalue', rowindex3, "tagno" ,$('#salickfleetSearch').jqxGrid('getcellvalue', rowBoundIndex, "tcno"));
          
          var rows = $('#salikgrid').jqxGrid('getrows');
          var rowlength= rows.length;
          if(rowindex3==rowlength-1)
          {
    
       	 $("#salikgrid").jqxGrid('addrow', null, {});      
        
	      }  
        $('#salickfleetsearchwindow').jqxWindow('close');
      
    	
    		 }); 

});
</script>
<div id="salickfleetSearch"></div>