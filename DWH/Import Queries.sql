SELECT       rv.*
FROM            Requests AS r WITH (nolock) 
						INNER JOIN base.ModelBase AS b WITH (nolock) ON b.ModelBaseKey = r.ModelBaseKey 
						INNER JOIN RequestsCards AS rc with(nolock) ON rc.RequestKey = r.RequestKey 
						INNER JOIN RequestsValues AS rv with(nolock) ON rv.RequestKey = r.RequestKey
WHERE        (b.CreatedDateUtc BETWEEN '20231030' AND '20231031')
