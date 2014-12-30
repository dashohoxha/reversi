{ P‰r t‰ gj‰tur l‰vizjen m‰ t‰ mir‰ }

Unit LF1U;

                    Interface

Uses LFU;

procedure Me_e_Mira(F:Fushe; ll:integer; Nvl:nivel; var L:lev);
{ Jep n‰ L l‰vizjen m‰ t‰ mir‰ t‰ lojtarit ll n‰ pozicionin F  }

                    Implementation

Type
     Shenjues=^qelize;
     qelize=record
               l:lev;
               pas:Shenjues;
            end;

Var  mbaroi:boolean;
     LMM:Shenjues;
     m:pointer;
     i,nmm,VMM:integer;
     T:array[0..4] of Fushe;
     VL:array[0..4] of integer;
     LV:array[0..4] of lev;

function Infinit(i:integer):integer;
{  Percakton vlerat  +infinit  dhe  -infinit  }
begin
  if odd(i) then Infinit:=100 else Infinit:=-100;
end;  { Infinit }

function Vlera(F:Fushe; ll:integer):integer;
var i,j,n1,n2,nc1,nc2,
    na1,na2:integer;
    cep,ane:boolean;

procedure CepAne(x,y:integer);
begin
  cep:=false; ane:=false;
  case x of
    1,8: case y of
           1,8: cep:=true;
           else ane:=true;
         end; { case y }
    else if y in [1,8] then ane:=true;
  end;  { Case x }
end;  { CepAne }

begin
  n1:=0;   n2:=0;
  nc1:=0;  nc2:=0;
  na1:=0;  na2:=0;
  for i:=1 to 8 do
    for j:=1 to 8 do begin
                     if F[i,j]=ll then begin
                                       n1:=n1+1;
                                       CepAne(i,j);
                                       if cep then nc1:=nc1+1
                                       else if ane then na1:=na1+1;
                                       end;
                     if F[i,j]=(-1)*ll then begin
                                            n2:=n2+1;
                                            CepAne(i,j);
                                            if cep then nc2:=nc2+1
                                            else if ane then na2:=na2+1;
                                            end;
                     end;
  if Nvl=me_pervoje then Vlera:=(n1+na1+3*nc1)-(n2+na2+3*nc2)
  else  Vlera:=n1-n2;
end;  { Vlera }

function Max(a,b:integer):integer;
begin
  if a>b then Max:=a else Max:=b;
end;  { Max }

function Min(a,b:integer):integer;
begin
  if a<b then Min:=a else Min:=b;
end;  { Min }

procedure KaloTeBiri;
begin
  i:=i+1;
  LV[i].x:=1;  LV[i].y:=1;
  LV[i].lloj:=(-1)*LV[i-1].lloj;
  Fushe_e_re(T[i-1],LV[i],T[i],false);
end;   {  KaloTeBiri  }

function Gjeth:boolean;
begin
  Gjeth:= (i=3);
end;  { Gjeth }

function NukKaVella:boolean;
begin
  NukKaVella:=(LV[i].x=8)and(LV[i].y=8);
end;   {  NukKaVella  }

procedure KaloTeVellai;
begin
  if LV[i].x=8 then begin
                    LV[i].x:=1;
                    LV[i].y:=LV[i].y+1;
                    end
  else  LV[i].x:=LV[i].x+1;
  Fushe_e_re(T[i-1],LV[i],T[i],false);
end;   {  KaloTeVellai  }

procedure MbajLMM;
{ Mban levizjet me te mira  }
var  p:Shenjues;

procedure Shto;
begin
 if nmm=0 then begin
               new(LMM);
               p:=LMM
               end
   else begin
        new(p^.pas);
        p:=p^.pas
        end;
 p^.l:=LV[1];
 p^.pas:=nil;
 nmm:=nmm+1;
end; { Shto }

begin   { MbajLMM }
  if VL[1]>VL[0] then begin
                      release(m);
                      nmm:=0;
                      Shto;
                      VMM:=VL[1];
                      end;
  if VL[1]=VL[0] then begin
                      p:=LMM;
                      while p^.pas<>nil do p:=p^.pas;
                      Shto;
                      end;
end;   {  MbajLMM  }

procedure Zgjidh(var L:lev);
{ Zgjedh rast‰sisht nj‰ l‰vizje nga l‰vizjet m‰ t‰ mira  }
var i,rnd:integer;
    p:Shenjues;
begin
  rnd:=random(nmm);
  p:=LMM;
  for i:=1 to rnd do p:=p^.pas;
  L:=p^.l;
  release(m);
end;   {  Zgjidh  }

function FLprn:boolean;
var b:boolean;
    x,y:integer;
begin
  if i=0 then FLprn:=true
  else begin
       x:=LV[i].x;
       y:=LV[i].y;
       b:= (T[i-1,x,y]=0);
       if b then
        if not ((x=1)or(y=1)or(x=8)or(y=8))  then
         if (T[i-1,x-1,y-1]=0)and(T[i-1,x-1,y]=0)and(T[i-1,x-1,y+1]=0)
             and(T[i-1,x+1,y-1]=0)and(T[i-1,x+1,y]=0)and(T[i-1,x+1,y+1]=0)
             and(T[i-1,x,y-1]=0)and(T[i-1,x,y+1]=0) then b:=false;
       FLprn:=b;
       end;
end;    {  Funnksion llogjik pranohet  }

procedure Fillest(F:Fushe; ll:integer; var L:lev);
var i,j:integer;
begin
  VL[0]:=-100;
  T[0]:=F;
  LV[1].lloj:=ll;
  for i:=1 to 8 do
    for j:=1 to 8 do
      if T[0,i,j]=0 then begin
                         LV[1].x:=i;  LV[1].y:=j;
                         Fushe_e_re(T[0],LV[1],T[1],false);
                         VL[1]:=Vlera(T[1],ll);
                         MbajLMM;
                         VL[0]:=Max(VL[1],VL[0]);
                         end;
  Zgjidh(L);
end;   {  Vlera m‰ e mir‰ si fillestar  }

procedure Me_e_Mira(F:Fushe; ll:integer; Nvl:Nivel; var L:lev);
var mbaroi,pranohet:boolean;
begin
  if Nvl=fillestar then begin
                        Fillest(F,ll,L);
                        exit;
                        end;
  i:=0;  T[0]:=F;  LV[0].lloj:=(-1)*ll;
  mbaroi:=false;
  while not(mbaroi) do
     begin
     pranohet:=FLprn;    { Funksion Logjik }
     if pranohet then
         if gjeth  then  begin
                         { Ndodhemi ne nje gjeth. Vleresojme levizjen dhe
                           kerkojme vleren me te mire per atin.            }
                         VL[i]:=Vlera(T[i],ll);
                         if VL[i]>=VL[i-2] then begin  { prerje alfa }
                                                i:=i-1;
                                                pranohet:=false;
                                                end
                         else  VL[i-1]:=Max(VL[i],VL[i-1]);
                                            { Nqs N-‡ift merret Min, }
                                            { nqs N-tek merret Max   }
                         end
          else  begin
                { kulm jo fundor ne pararendor }
                VL[i]:=Infinit(i);
                KaloTeBiri;
                end;
     if (gjeth)or(not pranohet) then
       begin
       while (i<>0) and (NukKaVella) do
          begin
          if VL[i-1]=Infinit(i-1) then VL[i-1]:=Vlera(T[i-1],ll);
          i:=i-1;
          { kulm jofundor ne pasrendor }
          if (not odd(i)) and (i<>0) then
                     begin
                     VL[i-1]:=Min(VL[i],VL[i-1]);
                     if VL[i]<VL[i-2] then i:=i-1; { prerje }
                     end;
          if odd(i) then begin
                         if (i=1)  then  MbajLMM;
                         VL[i-1]:=Max(VL[i],VL[i-1]);
                         if (i>=3)and(VL[i]>=VL[i-2]) then i:=i-1; {prerje}
                         end;
          end;  { while }
       if i<>0 then  KaloTeVellai  else  mbaroi:=true;
       end; { if gjeth ... }
     end;  { while not mbaroi  }
  Zgjidh(L);
end;   {  Me_e_Mira  }

begin
  LMM:=nil;
  mark(m);
  nmm:=0;
end.
