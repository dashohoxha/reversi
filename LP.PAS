program KTHIMI_I_FISHAVE;

Uses LFSU,LFU,LF1U,graph,crt;

Var  ch:char;

procedure Rradha(ll:integer);
var  l:lev;
     ng:integer;
begin
  l.lloj:=ll;
  if SiLuhet=dyshe then Lexo(L)
  else  begin
        with L do Gati(ll,x,y,ng);
        if ll=1 then  Lexo(L)
        else  Me_e_mira(Fu,-1,Nvl,L);
        end;
  nl:=nl+1;
  Levizje[nl]:=L;
  Fushe_e_re(Fu,L,Fu,true);
  ShNrPullave(n1,n2,ll);
end;  {  Rradha  }

begin  {  Kryesor  }
  repeat
    InitVar;
    while nl<60 do begin
                   Rradha(1);
                   Rradha(-1);
                   end;
    FundLoje(ch);
  until ch=Txt[6,2];
  Mbyllje;
end.
