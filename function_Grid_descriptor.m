function GD=function_Grid_descriptor(img, n_rows, m_columns)
%Gridding image into n*m cells * 3 colours into a vector [1, n*m*d]
%Add remainder columns or/and rows to the image if necessary.
[im_rows, im_cols, im_dims] = size(img);
n_remainder= n_rows - rem(im_rows, n_rows);
m_remainder= m_columns - rem(im_cols, m_columns);
% channel = zeros(size(img,1), size(img,2));
for c = 1:im_dims
    channel = img(:, : ,c);
    if n_remainder ~= n_rows
        if n_remainder ~= 0
        avg_last_rows = mean(channel(end-3:end,:));
        rows_add= avg_last_rows;
        channel=[channel;repmat(rows_add, n_remainder, 1)];  %add remainder rows
        end
    end
    if m_remainder ~= m_columns
        if m_remainder ~= 0
        avg_last_columns = mean(channel(:,end-3:end),2);
        columns_add= avg_last_columns;
        channel=[channel repmat(columns_add, 1, m_remainder)];  %add remainder columns
        end
    end
     % Gridding
    n = floor(size(channel,1)/n_rows);
    B= zeros(1, n_rows);
    B = B + n;                %build array: [n n n n] with n_rows
    m = floor(size(channel,2)/m_columns);
    C= zeros(1, m_columns);
    C = C + m;                %build array: [m m m m m m] with m_columns
    Cells = mat2cell(channel, B, C);
    number_of_cells= n_rows*m_columns;
    avgCell = zeros(1, n_rows*n_rows);
    for i = 1:number_of_cells
        avgCell(i)= mean(Cells{i}, 'all'); %vector 1xm*n
    end
    descriptor(:,:,c) = avgCell;   
end
% Average colour for each channel for each cell.
dRGB= [descriptor(:,:,1); descriptor(:,:,2); descriptor(:,:,3)]';
GD= dRGB(:)';
