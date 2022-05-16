format short
clc
clear all
%C = [ 3 5 ];
%a = [-1 -3; -1 -1]; 
%b = [-3 ; -2];
%C = [12 10];
%a = [-5 -1; -6 -5; -1 -4;];
%b = [-10 ;-30 ;-8];
C = [ 3 2 ];
a = [1 1; -1 -2];
b = [1 ; -3];
Noofvariables=2;
s=eye(size(a,1));
A = [a s b];
cost=zeros(1,size(A,2));
cost(1:Noofvariables)=C;
bv = Noofvariables+1:1:size(A,2)-1;
zjcj=cost(bv)*A-cost;
tab = [zjcj; A];
TABLE.Properties.VariableNames(1:size(tab,2))={'x_1','x_2','s_1','s_2','sol'};
display(TABLE);
RUN=true;
while RUN
    if any(A(:,size(A,2))<0)
        fprintf('the current BFS is not feasible\n');
        [lvg_val, pvt_row]=min(A(:,size(A,2)));
        if all(A(pvt_row,1:size(A,2)-1) >= 0)
            fprintf('infeasible solution\n');
            break;
        end
        for i=1:size(A,2)-1
            if A(pvt_row,i)<0
                m(i)=zjcj(i)/A(pvt_row,i);
            else
                m(i)=inf;
            end
        end
        [ent_val, pvt_col]=min(m);
        A(pvt_row,:)=A(pvt_row,:)/A(pvt_row,pvt_col);
        for i=1:size(A,1)
            if i~=pvt_row
                A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
            end 
        end
        b(pvt_row)=pvt_col;
        zjcj=zjcj-zjcj(pvt_col).*A(pvt_row,:);
        tab=[zjcj;A];
        TABLE=array2table(tab);
        TABLE.Properties.VariableNames(1:size(tab,2))={'x_1','x_2','s_1','s_2','sol'};
        display(TABLE);
    else
        RUN=false;
        fprintf('current BFS is Feasible and Optimal   \n')
    end
end
