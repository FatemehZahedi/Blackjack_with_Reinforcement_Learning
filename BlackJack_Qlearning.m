%clear;
%clc;
dim=10;
num_epi=1000000;
epsilon=0.28;
alpha=0.0009;
gamma=1;

%% initial Q(s,a) arbitrary
Q=zeros(dim,dim,2);

%% Repeat(for each episode):
for i=1:num_epi
    
    %%initialize s
    x=randi(dim);
    y=randi(dim);
    
    %xstart=x;
    %ystart=y;
    
    
    %matx=0;
    %maty=0;
    %step=0;
    
    %%Repeat (for each step of episode):
    % Using TD(0)
       % step=step+1;
        
       % matx(step)=x;
       % maty(step)=y;
        
        %%Choose a from s using policy derived from Q (epsilon-greedy)
        prob=rand();
        [val,in]=max(Q(x,y,:));
        if prob > epsilon
            %greedy
            action=in;
        else
            %nongreedy
            action=randi(2);
            while (action ==in)
                action=randi(2);
            end
        end
        
        %%Take action a, observe r,s'
        xnew=x;
        ynew=y;
        
        switch action
            case 1  %Hit
                s=randi(10);
                ynew=s+ynew;
            case 2  %Stick
                ynew=ynew;
        end
        
%         if ynew>9&& ynew<=10
%             reward=1;
%         elseif ynew > 10
%             reward=-1;
%         else
%             if xnew==1 || xnew>=8 || ynew<5
%                 reward=-1;
%             else
%                 reward=0;
%             end    
%                 
%         end
          f=0;
          count=0;
          xcom=xnew;
          if xcom==1
              f=1;
          end
          while (xcom<16)
            d=randi(10);
            if d==1
              f=1;
            end
            xcom=xcom+d;
             if xcom<=12
                  if f==1 && count==0
                  xcom=xcom+9;
                  count=1;
                  end
             end
             if xcom>21 && count==1
              xcom=xcom-9;
              count=0;
             end
          end
          ycom=ynew+11;
          
         if ycom==21 
             reward=1;
         elseif ycom>21
             reward=-1;
         else
            if ycom>xcom || xcom>21
                reward=1;
            elseif xcom>ycom
                reward=-1;
            elseif ycom==xcom
             reward=0;
            end
         end
              
        %% learning
        if ynew > 10
          Q(x,y,action)=Q(x,y,action)+alpha*(reward+0-Q(x,y,action));
          %break;
        else
        [val,next_act]=max(Q(xnew,ynew,:));
        Q(x,y,action)=Q(x,y,action)+alpha*(reward+(gamma*val)-Q(x,y,action));
        end
        
        %% Update the state
        %x=xnew;
        %y=ynew;
        
end
%% Drawing
VAL=zeros(10,10);
IND=zeros(10,10);
for i=1:10
    for j=1:10
        [va,ind]=max(Q(i,j,:));
        VAL(i,j)=va;
        IND(i,j)=ind;
    end
end
Y=[1 2 3 4 5 6 7 8 9 10];
X=[12 13 14 15 16 17 18 19 20 21];
figure(1);
mesh(X,Y,VAL);
%IND
p=zeros(1,10);
for k=1:10
    pi=IND(k,:)==2;
    [vp,vi]=max(pi);
    p(1,k)=min(vi)+10;
end
figure(2);
hold all
axis([1 11 11 21]);
t1=1:1:2;
p1=[p(1,1),p(1,1)];
plot(t1,p1,'k');
t2=2:1:3;
p2=[p(1,2),p(1,2)];
plot(t2,p2,'k');
t3=3:1:4;
p3=[p(1,3),p(1,3)];
plot(t3,p3,'k');
t4=4:1:5;
p4=[p(1,4),p(1,4)];
plot(t4,p4,'k');
t5=5:1:6;
p5=[p(1,5),p(1,5)];
plot(t5,p5,'k');
t6=6:1:7;
p6=[p(1,6),p(1,6)];
plot(t6,p6,'k');
t7=7:1:8;
p7=[p(1,7),p(1,7)];
plot(t7,p7,'k');
t8=8:1:9;
p8=[p(1,8),p(1,8)];
plot(t8,p8,'k');
t9=9:1:10;
p9=[p(1,9),p(1,9)];
plot(t9,p9,'k');
t10=10:1:11;
p10=[p(1,10),p(1,10)];
plot(t10,p10,'k');
text(5.42, 14.5, 'HIT', 'clipping', 'off','FontSize',18);
text(5, 19, 'STICK', 'clipping', 'off','FontSize',18);
hold off



          
                
        
