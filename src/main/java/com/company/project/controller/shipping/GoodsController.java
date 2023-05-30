package com.company.project.controller.shipping;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.company.project.entity.shipping.Goods;
import com.company.project.service.shipment.GoodsService;
//import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import java.util.List;
import com.company.project.common.utils.DataResult;




/**
 *
 *
 * @author wenbin
 * @email *****@mail.com
 * @date 2023-04-16 20:08:24
 */
@Controller
@RequestMapping("/")
public class GoodsController {
    @Autowired
    private GoodsService goodsService;


    /**
     * 跳转到页面
     */
    @GetMapping("/index/goods")
    public String goods() {
        return "goods/list";
    }

    @ApiOperation(value = "新增")
    @PostMapping("goods/add")
    @PreAuthorize("hasAuthority('goods:add')")
    @ResponseBody
    public DataResult add(@RequestBody Goods goods){
        goodsService.save(goods);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("goods/delete")
    @PreAuthorize("hasAuthority('goods:delete')")
    @ResponseBody
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids){
        goodsService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("goods/update")
    @PreAuthorize("hasAuthority('goods:update')")
    @ResponseBody
    public DataResult update(@RequestBody Goods goods){
        goodsService.updateById(goods);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("goods/listByPage")
    @PreAuthorize("hasAuthority('goods:list')")
    @ResponseBody
    public DataResult findListByPage(@RequestBody Goods goods){
        LambdaQueryWrapper<Goods> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
//        queryWrapper.eq(Goods::getId, goods.getId());
        queryWrapper.orderByAsc(Goods::getId);
        IPage<Goods> iPage = goodsService.page(goods.getQueryPage(), queryWrapper);
        return DataResult.success(iPage);
    }

}
