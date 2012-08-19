#tag Class
Class AttributedString
Inherits NSAttributedString
	#tag Method, Flags = &h0
		Sub Constructor(fromNSAttributedString as NSAttributedString)
		  //# Create an AttributedString from its Cocoa counterpart
		  
		  #if TargetMacOS
		    if Cocoa.InheritsFromClass( fromNSAttributedString, "NSMutableAttributedString" ) then
		      Mutable = true
		    end if
		    
		    me._id = fromNSAttributedString.id
		    NSbacking = fromNSAttributedString
		    selection = Cocoa.NSMakeRange( 0, 0 )
		  #endif
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateFromHTML(HTMLdata as NSData, baseURL as NSURL = nil) As AttributedString
		  
		  #if TargetMacOS
		    dim nsas as NSAttributedString = NSAttributedString.CreateFromHTML( HTMLData, baseURL )
		    
		    if nsas<>nil then
		      return   new AttributedString( nsas )
		    end if
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		 Shared Function CreateFromRTF(RTFdata as NSData) As AttributedString
		  #if TargetMacOS
		    dim nsas as NSAttributedString = NSAttributedString.CreateFromRTF( RTFData )
		    
		    if nsas<>nil then
		      return   new AttributedString( nsas )
		    end if
		    
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Length() As integer
		  //# Return the length of the AttributedString
		  
		  #if TargetMacOS
		    return  NSbacking.Length
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Mid(startPosition as integer, length as integer = -1) As AttributedString
		  //# Return the attributed substring in the given range
		  
		  //@ The startPosition must be in the range 1 to Length()
		  //@ If the length is omitted or negative, the full string starting at 'startPosition' is returned
		  
		  #if TargetMacOS
		    dim nsas as NSAttributedString
		    dim realrange as Cocoa.NSRange
		    
		    if startPosition<1 OR startPosition>me.Length then
		      raise   new OutOfBoundsException
		    else
		      realrange.location = startPosition - 1
		    end if
		    
		    if (startPosition + length) > me.Length OR length<0 then //Auto-adjust length
		      realrange.length = me.length - realrange.location
		    else
		      realrange.length = length
		    end if
		    
		    nsas = NSbacking.AttributedSubstringFromRange( realrange )
		    
		    return  new AttributedString( nsas )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Add(aString as AttributedString) As AttributedString
		  //# Allows two AttributedStrings to be concatenated using the "+" operator
		  
		  #if TargetMacOS
		    dim ns2 as NSAttributedString
		    
		    ns2 = NSbacking + aString.NSbacking
		    
		    return  new AttributedString( ns2 )
		  #endif
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function StringValue() As string
		  //# Return the raw contents of the AttributedString without the attributes
		  
		  #if TargetMacOS
		    return  NSbacking.StringValue
		  #endif
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Note
			//# The underlying NSAttributedString handle (same as "id" )
		#tag EndNote
		#tag Getter
			Get
			  //# Handle of the object
			  
			  return Integer( _id )
			End Get
		#tag EndGetter
		Handle As integer
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Mutable As Boolean
	#tag EndProperty

	#tag Property, Flags = &h0
		NSbacking As NSAttributedString
	#tag EndProperty

	#tag Property, Flags = &h21
		Private selection As NSRange
	#tag EndProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  
			  #if TargetMacOS
			    return   selection.length
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS
			    selection.length = value
			  #else
			    #pragma unused value
			  #endif
			End Set
		#tag EndSetter
		Private SelLength As Integer
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h21
		#tag Getter
			Get
			  
			  #if TargetMacOS
			    return   selection.location
			  #endif
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  
			  #if TargetMacOS
			    selection.location = value
			  #else
			    #pragma unused value
			  #endif
			End Set
		#tag EndSetter
		Private SelStart As Integer
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
			InheritedFrom="NSObject"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Handle"
			Group="Behavior"
			Type="integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
