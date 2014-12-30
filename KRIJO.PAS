var f:file of string;
    g:text;
    txt,lng,str:string;
    i:integer;
begin
  i:=0;
  if paramcount<>1 then begin
                        writeln;
                        writeln('Usage :  KRIJO  name_lng');
                        writeln('where name_lng is : DEUTSCH or FRANCAIS or ITALIANO .');
                        writeln;
                        halt;
                        end;
  txt:=paramstr(1)+'.txt';
  lng:=paramstr(1)+'.lng';
  for i:=1 to length(txt) do txt[i]:=UpCase(txt[i]);
  for i:=1 to length(lng) do lng[i]:=UpCase(lng[i]);
  assign(g,txt);
  assign(f,lng);
  {$I-} reset(g); {$I+}
  if IOresult<>0 then begin
                      writeln('File ',txt,' not found in this directory.');
                      halt;
                      end;
  rewrite(f);
  while not eof(g) do
      begin
      readln(g,str);
      str:=copy(str,4,length(str)-3);
      write(f,str);
      end;
  close(g);
  close(f);
  writeln('File ',lng,' created');
end.