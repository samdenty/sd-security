object TPersHolder
  P.Name = 'SD-Security Logs'
  P.Extensions = 'sds_log'
  P.SyntaxBlocks = <
    item
      Name = 'Default'
      ID = 0
      FIIntNum = 2
      FIFloatNum = 5
      FIHexNum = 6
      FIDirective = 4
      UseSingleLineComments = True
      UseStrings = True
      UseSingleLineStrings = True
      UseNumbers = True
      UseSuffixedNumbers = True
      UseMultipleNumSuffixes = False
      BlockDelimiters = <>
      SingleLineCommentDelimiters = <
        item
          FontID = 3
          LeftDelimiter = '||'
        end>
      SingleLineStringDelimiters = <
        item
          FontID = 1
          LeftDelimiter = '||'
          RightDelimiter = '||'
        end
        item
          FontID = 10
          LeftDelimiter = '|Info:'
          RightDelimiter = '|'
        end
        item
          FontID = 7
          LeftDelimiter = '|Time:'
          RightDelimiter = '|'
        end
        item
          FontID = 8
          LeftDelimiter = '|Date:'
          RightDelimiter = '|'
        end
        item
          FontID = 9
          LeftDelimiter = '|PC:'
          RightDelimiter = '|'
        end
        item
          FontID = 11
          LeftDelimiter = '|Username:'
          RightDelimiter = '|'
        end
        item
          FontID = 12
          LeftDelimiter = '|OS:'
          RightDelimiter = '|'
        end
        item
          FontID = 13
          LeftDelimiter = '|Serial:'
          RightDelimiter = '|'
        end>
      NumSuffixes = <
        item
          LeftDelimiter = '|'
        end>
    end>
  P.FontTable = <
    item
      FontID = 2
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic, fsUnderline]
    end
    item
      FontID = 3
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clFuchsia
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
    end
    item
      FontID = 1
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16754176
      Font.Height = -13
      Font.Name = 'Ubuntu Condensed'
      Font.Style = []
      BackColor = 15329769
      UseDefFont = False
      UseDefBack = False
    end
    item
      FontID = 5
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic, fsUnderline]
    end
    item
      FontID = 6
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = [fsItalic, fsUnderline]
    end
    item
      FontID = 7
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Ubuntu Condensed'
      Font.Style = []
      BackColor = clRed
      UseDefFont = False
      UseDefBack = False
    end
    item
      FontID = 8
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Ubuntu Condensed'
      Font.Style = []
      BackColor = 57194
      UseDefFont = False
      UseDefBack = False
    end
    item
      FontID = 9
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 16645887
      Font.Height = -13
      Font.Name = 'Ubuntu Condensed'
      Font.Style = [fsBold]
      BackColor = 33023
      UseDefFont = False
      UseDefBack = False
    end
    item
      FontID = 10
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Ubuntu Condensed'
      Font.Style = []
      BackColor = clInactiveCaptionText
      UseDefFont = False
      UseDefBack = False
    end
    item
      FontID = 11
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Ubuntu Condensed'
      Font.Style = []
      BackColor = clBlue
      UseDefFont = False
      UseDefBack = False
    end
    item
      FontID = 12
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -13
      Font.Name = 'Ubuntu Condensed'
      Font.Style = []
      BackColor = 2293754
      UseDefFont = False
      UseDefBack = False
    end
    item
      FontID = 13
      GlobalAttrID = 'Custom'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Ubuntu Condensed'
      Font.Style = []
      BackColor = 14800185
      UseDefFont = False
      UseDefBack = False
    end>
  P.CodeTemplates = <>
  P.SyntaxVersion = 3
end
