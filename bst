#include <stdio.h>
#include <stdlib.h>

struct node
{
    int data;
    struct node *r; 
    struct node *l; 
};

struct node* search(struct node *root, int x)
{
    if(root==NULL || root->data==x)
        return root;
    else if(x>root->data) 
        return search(root->r, x);
    else if (x<root->data)
        return search(root->l,x);
	else
		printf("Serach Not Found");
}


struct node* mini(struct node *root)
{
    if(root == NULL)
        return NULL;
    else if(root->l != NULL) 
        return mini(root->l); 
    return root;
}


struct node* new_node(int x)
{
    struct node *p;
    p = malloc(sizeof(struct node));
    p->data = x;
    p->l = NULL;
    p->r = NULL;

    return p;
}

struct node* insert(struct node *root, int x)
{
    if(root==NULL)
        return new_node(x);
    else if(x>root->data) 
        root->r = insert(root->r, x);
    else 
        root->l = insert(root->l,x);
    return root;
}

struct node* delete(struct node *root, int x)
{
    if(root==NULL)
        return NULL;
    if (x>root->data)
        root->r = delete(root->r, x);
    else if(x<root->data)
        root->l = delete(root->l, x);
    else
    {
        if(root->l==NULL && root->r==NULL)
        {
            free(root);
            return NULL;
        }
        else if(root->l==NULL || root->r==NULL)
        {
            struct node *temp;
            if(root->l==NULL)
                temp = root->r;
            else
                temp = root->l;
            free(root);
            return temp;
        }
        else
        {
            struct node *temp = mini(root->r);
            root->data = temp->data;
            root->r = delete(root->r, temp->data);
        }
    }
    return root;
}

void inorder(struct node *root)
{
    if(root!=NULL) //
    {
        inorder(root->l); //
        printf(" %d ", root->data);
        inorder(root->r);
    }
}

int main()
{
    struct node *root;
	int c,e;
    root = new_node(40);
    insert(root,25);insert(root,78);insert(root,10);insert(root,32);insert(root,50);insert(root,93);insert(root,3);insert(root,17);insert(root,30);insert(root, 38);
    inorder(root);
    printf("\n");
    root = delete(root, 10); root = delete(root, 50);root = delete(root, 3);root = delete(root, 78);
    inorder(root);
	printf("\nBST Explicit\n");
	while(1)
	{	printf("Main Menu\n");
		printf("\n  1. Insert \n 2. Delete \n 3. Find \n 4. Exit \n");
		printf("Enter Choice\n");
		scanf("%d",&c);
		switch(c)
		{	
			case 1: printf("Enter data to insert\n");
					scanf("%d",&e);
					insert(root,e);
					inorder(root);
					break;
			case 2: printf("Enter data to delete\n");
					scanf("%d",&e);
					root=delete(root,e);
					inorder(root);
					break;
			case 3: printf("Enter data to find\n");
					scanf("%d",&e);
					if(search(root, e) == NULL)
				        printf("not found\n");
			        else
				        printf("found\n");
					break;
			case 4: exit(0);
		}
		printf("\n");
	}
    return 0;
}
