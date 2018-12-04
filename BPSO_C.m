%This file is intened to perform the Bianry Particle Swarm Genetic search Algorithm
% The change of Ant_Size and genertion_n would impact on its performance
function [best,xGbest]=BPSO_C(fhd,uv,yv,D,var_n,K,mut_rate)
tt=200;	% Times of moving
popuSize = 30;		% Population size
popu = rand(popuSize, var_n) > 0.5;
vmax=3;
xGbest=zeros(1, var_n);
P_Diff=zeros(1, var_n);
G_Diff=zeros(1,var_n);
V=zeros(popuSize, var_n);
vel=rand(popuSize, var_n);
Elite_popu=rand(2,var_n)>0.5;
GlobalBest=0;
index3=2;
index4=1;

for i = 1:tt
    
    %Calculate fitness
    [fitness]=fhd(popu,uv,yv,popuSize,D,K);
    %Global Update
    %When multiple best,Choose the minimum feature best as local best and second
    best=max(fitness);
    Multiple=find(fitness==best);
    if size(Multiple,2)>1
        Num_Fea=sum(popu(Multiple,:),2);
        Small=min(Num_Fea);
        X=find(Num_Fea==Small,1,'first');
        index1=Multiple(X);
    else
        index1=find(fitness==best,1,'first');
    end
    second=max(fitness(fitness<max(fitness)));
    Multiple=find(fitness==second);
    if size(Multiple,2)>1
        Num_Fea=sum(popu(Multiple,:),2);
        Small=min(Num_Fea);
        X=find(Num_Fea==Small,1,'first');
        index2=Multiple(X);
    else
        index2=find(fitness==second,1,'first');
    end
    %If the local best is better, then update Gbest. Or Replace
    if GlobalBest>best
        popu([index3 index4], :) = Elite_popu([1 2], :);
        xPbest=popu(index4,:);
    else
        Elite_popu([1 2], :) = popu([index1 index2], :);
        xPbest=popu(index2,:);
    end
    if best>GlobalBest
        GlobalBest=best;
        xGbest=popu(index1,:);
    end
    
    
    % Velocity Update
    w=abs(sin(0.12*tt));
    c1=1;
    c2=1;
    for A =2:popuSize
        for F=1:var_n
            P_Diff(A,F)=c1*randi([-1 1],1)*abs(popu(A,F)-xPbest(1,F));
            G_Diff(A,F)=c2*randi([-1 1],1)*abs(popu(A,F)-xGbest(1,F));
            V(A,F)=vel(A,F)*w+P_Diff(A,F)+G_Diff(A,F);
        end
    end
    
    
    %Signule saturation
    for L=1:popuSize
        for j=1:var_n
            if abs(V(L,j))>vmax
                V(L,j)=vmax*sign(V(L,j));
            end
        end
    end
    
    veln=logsig(V);
    
    
    %position Update
    for M=1:popuSize
        for j=1:var_n
            if veln(M,j)<0.5
                
                popu(M,j)=not(popu(M,j));
                
            else
                popu(M,j)=(popu(M,j));
            end
        end
    end
    
    %Restore the best
    popu([index1 index2], :)=Elite_popu([1 2], :);
    
    
    %Mutation
    mask = rand(popuSize, var_n) < mut_rate;
    new_popu = xor(popu, mask);
    popu =new_popu;
    popu([index1 index2], :)=Elite_popu([1 2], :);
    
    
end
end